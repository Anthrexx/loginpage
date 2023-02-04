import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class utils{
  void ToastMessage(String string){
    Fluttertoast.showToast(
        msg: "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}