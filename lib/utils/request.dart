import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../utils/shared_preferences.dart';
import '../pages/home_page.dart';
import '../pages/auth_page.dart';
import '../pages/maps_page.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as constants;

final String host = constants.host;

class Request {
  static Future<bool> checkAuth(context, id) async {
    try {
      var url = '$host/users/$id';
      print(await SharedPreferencesRequest.getToken());
      print(url);
      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SharedPreferencesRequest.getToken()}',
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print(' ${jsonDecode(response.body)['name']}');
        SharedPreferencesRequest.setUser({
          'id': jsonDecode(response.body)['_id'],
          'name': jsonDecode(response.body)['name'],
          'email': jsonDecode(response.body)['email'],
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
           //MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        return true;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
        return false;
      }
    } catch (error) {
      print(error);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      ); 
      return false;
    }
  }
}
