import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/request.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountPageState createState() => new _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            FlatButton(
                onPressed: () => Request.getReports(0),
                child: Text('get Reports')),
            FlatButton(
                onPressed: () => Request.getAds(), child: Text('get Ads')),
            FlatButton(
                onPressed: () => Request.getPoints(),
                child: Text('get Points')),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _onFloatingActionButtonPressed,
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
    );
  }

  void _onFloatingActionButtonPressed() {}
}
