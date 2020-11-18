import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../utils/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart' as constants;

final String host = constants.host;

class Request {
  static Future<bool> checkAuth(id) async {
    try {
      EasyLoading.show(status: 'Ожидайте...');
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
        print(' ${jsonDecode(response.body)['user']['name']}');
        SharedPreferencesRequest.setUser({
          'id': jsonDecode(response.body)['user']['_id'],
          'name': jsonDecode(response.body)['user']['name'],
          'email': jsonDecode(response.body)['user']['email'],
        });
        return true;
      } else {
        EasyLoading.showError('Ошибка: ${jsonDecode(response.body)}');
        return false;
      }
    } catch (error) {
      EasyLoading.showError('Ошибка: $error');
      return false;
    }
  }
}
