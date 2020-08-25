import 'package:flutter/material.dart';
import 'package:flutter_app/base/bases_statefulwidget.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/network/request/user_request.dart';
import 'package:flutter_app/network/rest_client.dart';
import 'package:flutter_app/screens/signup.dart';
import 'package:flutter_app/utils/shared_preference.dart';
import 'package:flutter_app/widget/basewidget.dart';
import 'package:flutter_app/widget/button.dart';

import 'home.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}
class _SignInScreenState extends BaseStatefulState<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   // var config = AppConfig.of(context);
    return Scaffold(
      appBar: appBarWithTitle(context, 'SignIn'),
      body: baseGestureDetector(context,
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widgetLogo(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration:
                          inputDecoration('Email', Icons.email),
                          validator: (val) {
                            return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val)
                                ? null
                                : "Enter correct email";
                          },
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration:
                          inputDecoration('Password', Icons.lock),
                          controller: _passwordController,
                          validator: (val) {
                            return val.length >= 6
                                ? null
                                : "Password 6+ characters";
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NormalButton(
                    onPressed: () {
                      _handelSigIn();
                    },
                    title: 'Sig in'),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Register now",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black87,
                            fontSize: 15),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  _handelSigIn() async{
    if (formKey.currentState.validate()) {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      setState(() {
        isLoading =true;
      });
      UserRequest userLogin = new UserRequest.login(email:_emailController.text,password:_passwordController.text);
      var result =await restApi.login(userLogin);
      if(result!=null){
        setState(() {
          isLoading =false;
        });
        if(result.user!=null){
          _saveData(result.user);

        }else{
          showBaseDialog("Error", result.message);
        }

      }
      else{
        setState(() {
          isLoading =false;
        });
        showBaseDialog("Error", "Please try again");
      }
    }
  }
  _saveData(UserModel userModel){
    SharedPre.saveBool(SharedPre.sharedPreIsLogin, true);
    SharedPre.saveString(SharedPre.sharedPreFullName, userModel.name);
    SharedPre.saveString(SharedPre.sharedPreEmail, userModel.email);
    SharedPre.saveString(SharedPre.sharedPreAvatar, userModel.avatar);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }
}
