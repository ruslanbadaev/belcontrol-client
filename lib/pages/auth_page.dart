import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import '../constants.dart' as constants;
import '../utils/shared_preferences.dart';
import '../utils/request.dart';
//import '../pages/home_page.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String host = constants.host;
  bool _passwordVisible = false;
  bool _isRegister = false;
  //bool _isAuth = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: FlutterEasyLoading(
      child: Center(
          child: Stack(children: [
        WeatherBg(
      /* 
      heavyRainy,
      heavySnow,
      middleSnow,
      thunder,
      lightRainy,
      lightSnow,
      sunnyNight,
      sunny,
      cloudy,
      cloudyNight,
      middleRainy,
      overcast,
      hazy, 
      foggy, 
      dusty,
      */
            weatherType: WeatherType.overcast,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height),
/*         Center(
            child: FlatButton(
                onPressed: () => getAuthModal(), child: Text('auth'))), */
        //Image.asset('assets/images/billboard.png',height: MediaQuery.of(context).size.height),
        Center(
            child: Container(
          padding: EdgeInsets.all(18),
          width: MediaQuery.of(context).size.width * 0.8,
          height: _isRegister
              ? MediaQuery.of(context).size.height * 0.6
              : MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.9),
            boxShadow: [
              //BoxShadow(color: Colors.blue, spreadRadius: 3),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(_isRegister ? 'Регистрация' : 'Вход',
                  style: TextStyle(fontSize: 32)),
              Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isRegister)
                      Container(
                          child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          icon: IconButton(
                              icon: Icon(
                            Icons.portrait_rounded,
                            size: 32,
                          )),
                          labelText: 'Имя',
                        ),
                      )),
                    SizedBox(height: 24),
                    Container(
                        child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        icon: IconButton(
                            icon: Icon(
                          Icons.login_rounded,
                          size: 32,
                        )),
                        labelText: 'Логин',
                      ),
                    )),
                    SizedBox(height: 24),
                    Container(
                        child: TextFormField(
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        icon: IconButton(
                          icon: _passwordVisible
                              ? Icon(
                                  Icons.lock_open_rounded,
                                  size: 32,
                                )
                              : Icon(
                                  Icons.lock_rounded,
                                  size: 32,
                                ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        labelText: 'Пароль',
                      ),
                    )),
                  ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                FlatButton(
                  padding: EdgeInsets.all(18),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25.0)),
                  onPressed: () async =>
                      //Request.checkAuth(await SharedPreferencesRequest.getUserId()),
  
                    _isRegister
                      ? authRequest('register', {
                          'name': nameController.text.toString(),
                          'email':
                              emailController.text.toString().toLowerCase(),
                          'password': passwordController.text.toString()
                        })
                      : authRequest('login', {
                          'email':
                              emailController.text.toString().toLowerCase(),
                          'password': passwordController.text.toString()
                        }), 
                  child: Text(
                    _isRegister ? 'Регистрация' : 'Войти',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  onPressed: () => setState(() {
                    _isRegister = !_isRegister;
                  }),
                  child: Text(
                    _isRegister ? 'Войти' : 'Регистрация',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ],
          ),
        )),
      ])),


    ));
  }




  
  void authRequest(authType, body) async {
    EasyLoading.show(status: 'Ожидайте...');
    try {
      var url = '$host/$authType';
      var response = await http.post(url, body: body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print(' ${jsonDecode(response.body)['user']['name']}');
        EasyLoading.showSuccess(
            'Добро пожаловать на портал, ${jsonDecode(response.body)['user']['name']}');

        SharedPreferencesRequest.setToken(jsonDecode(response.body)['token']);
        SharedPreferencesRequest.setUser({
          'id': jsonDecode(response.body)['user']['_id'],
          'name': jsonDecode(response.body)['user']['name'],
          'email': jsonDecode(response.body)['user']['email'],
        });
        await Request.checkAuth(
              context, await SharedPreferencesRequest.getUserId()) ;
      } else {
        EasyLoading.showError('Ошибка: ${jsonDecode(response.body)}');
      }
    } catch (error) {
      EasyLoading.showError('Ошибка: $error');
    }
    EasyLoading.dismiss();
  }

/*   setToken(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    await prefs.setString('token', value);
  }

  setUser(Map value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(value);
    await prefs.setString('id', value['id']);
    await prefs.setString('name', value['name']);
    await prefs.setString('email', value['email']);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Map> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getString('id'),
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
    };
  } */
}
