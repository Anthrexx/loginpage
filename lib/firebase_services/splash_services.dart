import 'package:flutter/material.dart';
import 'dart:async';

import 'package:login/pages/auth/login_screen.dart';


class SplashServices{
  void islogin( BuildContext context){
    Timer( const Duration(seconds: 3), ()=>
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())));

  }
}