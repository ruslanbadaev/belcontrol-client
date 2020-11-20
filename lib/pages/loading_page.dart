import 'package:flutter/material.dart';
import 'home_page.dart';
import 'auth_page.dart';
import '../main.dart';
import '../utils/request.dart';
import '../utils/shared_preferences.dart';


class LoadingPage extends StatefulWidget {
  LoadingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}



class _LoadingPageState extends State<LoadingPage> {


    void initState() {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
           await Request.checkAuth(
              context, await SharedPreferencesRequest.getUserId()) 
/*                       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
           //MaterialPageRoute(builder: (context) => MyHomePage()),
        ) */
        });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: 
            new Text('loading...'),
          
        
      ),

    );
  }
}
