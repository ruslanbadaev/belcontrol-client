import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRequest {

  static setToken(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    await prefs.setString('token', value);
  }

  static setUser(Map value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    await prefs.setString('id', value['id']);
    await prefs.setString('name', value['name']);
    await prefs.setString('email', value['email']);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }
}
