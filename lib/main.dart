import 'package:belcontrol/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/maps_page.dart';
import 'pages/loading_page.dart';
import 'pages/applications_page.dart';

import './router.dart';
import './utils/request.dart';
import './utils/shared_preferences.dart';

void main() async => {
      runApp(new Main()),
      //Request.checkAuth(await SharedPreferencesRequest.getUserId())
    };

class Main extends StatefulWidget {
  Main({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainState createState() => new _MainState();
}

class _MainState extends State<Main> {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        textTheme: GoogleFonts.comfortaaTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: new LoadingPage(title: 'Flutter Demo Home Page'),
    );
  }
}

/* class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        textTheme: GoogleFonts.comfortaaTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
} */

/* import 'package:flutter/material.dart';
import 'router.dart' as router;
import './pages/page1.dart';
import './pages/page2.dart';
import 'pages/page_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageContainer(),
    );
  }
}
 */
