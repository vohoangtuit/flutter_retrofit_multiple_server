import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin.dart';
import 'package:flutter_app/utils/shared_preference.dart';
import 'package:flutter_app/widget/basewidget.dart';
import 'package:flutter_app/widget/text_style.dart';

import 'home.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widgetLogo(),
            SizedBox(height: 20,),
            Text('Welcome ',style: textBlueLarge(),textAlign: TextAlign.center,)
          ],
        ),
      )),
    );
  }
  @override
  void initState() {
    super.initState();
    checkLogin();
  }
  checkLogin()async{
    await SharedPre.getBoolKey(SharedPre.sharedPreIsLogin).then((value){
      Future.delayed(Duration(seconds: 3),()async{
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        if(value!=null){
          if(value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
          }
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
        }
      }
      );
    });

  }
}
