import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

import '../utils/request.dart';
import '../main.dart';

class ApplicationsPage extends StatefulWidget {
  ApplicationsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ApplicationsPageState createState() => new _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  void initState() {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => {
          setState(() async {
            reports = await Request.getReports();
          })
        });
  }

  Map reports = {};
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: /* new Column(
          children: <Widget>[ */
            PagewiseGridView.count(
              pageSize: 10,
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.555,
              
              padding: EdgeInsets.all(15.0),
              noItemsFoundBuilder: (context) {
                return Text('No Items Found');
              },
              itemBuilder: (context, entry, index) {
                // return a widget that displays the entry's data
              },
              pageFuture: (pageIndex) {
                // return a Future that resolves to a list containing the page's data
              },
            ),
/*             Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    // BoxShadow(color: Colors.green, spreadRadius: 3),
                  ],
                ),
                margin: EdgeInsets.all(12),
                child: Text('${reports}')), */
          //],
        //),
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
