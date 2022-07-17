
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'login_screens/login.dart';

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          height: double.infinity,
          child: EasySplashScreen(
            backgroundColor:backgrouColor ,
            logo: Image.asset('assets/images/splash.png'),
            logoSize: 300,
            //title: Text('MedLife',style: TextStyle(color: KMainColor,fontSize: 25),),
            navigator: Login(),
            showLoader: true,
            loadingText: Text("Loading...",style: TextStyle(color: Colors.white),),
            durationInSeconds: 7,
          ),
        ),

    );
  }
}