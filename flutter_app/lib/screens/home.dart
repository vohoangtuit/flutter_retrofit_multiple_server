
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/bases_statefulwidget.dart';
import 'package:flutter_app/screens/signin.dart';
import 'package:flutter_app/utils/shared_preference.dart';
import 'package:flutter_app/widget/basewidget.dart';
import 'package:flutter_app/widget/button.dart';
import 'package:flutter_app/widget/loading.dart';
import 'package:flutter_app/widget/text_style.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulState<HomeScreen> {
  String name='';
  String email='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context, 'Home'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(name,style: mediumTextRed(),),
            SizedBox(height: 10,),
            Text(email,style: mediumTextRed(),),
            SizedBox(height: 20,),
            NormalButton(onPressed: (){
              _signOut();
            },title: 'Log Out',),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }
  _getProfile()async{
    String _name = await SharedPre.getStringKey(SharedPre.sharedPreFullName);
    String _email = await SharedPre.getStringKey(SharedPre.sharedPreEmail);
    setState(() {
      name =_name;
      email =_email;
    });
  }
  _signOut(){
    SharedPre.clearData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignInScreen()));
  }

}
