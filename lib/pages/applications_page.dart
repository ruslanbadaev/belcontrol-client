import 'package:flutter/material.dart';
import '../main.dart';

class ApplicationsPage extends StatefulWidget {
  ApplicationsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ApplicationsPageState createState() => new _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            Container(
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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          //height: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              child: Image.network(
                                  'https://www.proreklamu.com/media/upload/news/49779/12281.jpg'))),
                      Container(
                          //color: Colors.red,
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(4),
                                        child: Text('Имя Фамилия',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Container(
                                      margin: EdgeInsets.all(4),
                                        child: Text('Сегодня в 22:23',
                                        style: TextStyle(color: Colors.grey))),
                                  ]),
                              Container(
                                      margin: EdgeInsets.all(4),
                                        child: Text(
                                  'Здесь короткое описание. Остальное на новой странице после нажатия на заявку.')),
                              SizedBox()
                            ],
                          ))
                    ])),
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
