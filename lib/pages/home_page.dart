import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'applications_page.dart';
import 'maps_page.dart';
import 'account_page.dart';
import 'auth_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    ApplicationsPage(),
    MapsPage(),
    AccountPage(),
  ];

  List<int> _history = [0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAuth()
          ? AppBar(
              title: Text('Название приложения и логотип'),
            )
          : null,
      body: _isAuth() ? _children[_currentIndex] : AuthPage(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _isAuth()
          ? AnimatedBottomNavigationBar(
              icons: <IconData>[
                Icons.list_alt_rounded,
                Icons.map_rounded,
                Icons.person,
                //Icons.list_alt_rounded,
              ],
              splashRadius: 25,
              activeIndex: _currentIndex,
              gapLocation: GapLocation.none,
              activeColor: Colors.blue,
              splashColor: Colors.blue,
              notchSmoothness: NotchSmoothness.smoothEdge,
              leftCornerRadius: 10,
              rightCornerRadius: 10,
              onTap: (index) => onTabTapped(index),
            )
          : SizedBox(),
    );
  }

  bool _isAuth() {
    try {
      
    } catch (e) {
      
    }


    return false;
  }

  void onTabTapped(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }
}
