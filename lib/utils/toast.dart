import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class MyToast {
  static show(text){
    Fluttertoast.showToast(
      msg: text.toString(),
      //toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.grey[700],
      fontSize: 16.0
    );
  }
}