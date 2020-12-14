import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
//import 'package:photo_view/photo_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:full_screen_image/full_screen_image.dart';
//import 'package:zoomable_image/zoomable_image.dart';
//import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import '../constants.dart' as constants;
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
          _refresh()
          //setState(() async {
          //reports = await Request.getReports();
          //})
        });
  }

  int get count => reports.length;
  List reports = [];
  int nextPage = 1;
  int lengthOfPages = 0;
  void load() {
    print("load");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: RefreshIndicator(
          child: LoadMore(
            isFinish: count >= lengthOfPages,
            onLoadMore: _loadMore,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final double height = MediaQuery.of(context).size.height;
                return Container(
                  //height: 440.0,
                  margin: EdgeInsets.only(top: 12, bottom: 12),
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width*0.8,
                  alignment: Alignment.center,
                  child: Column(children: [
                    /*                    FlatButton(
                        child: Text('resize'),
                        onPressed: () => setState(() {
                              foolscreenImage = !foolscreenImage;
                            })), */
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        autoPlay: false,
                      ),
                      items: List.generate(reports[index]['files'].length, (i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width*0.8,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(/* color: Colors.amber */),
/*                                 child: Image.network(
                                    '${constants.host}/${reports[index]['files'][i]['path']}') */
                                child: FullScreenWidget(
                                  backgroundColor: Colors.black12,
                                  child: Center(
                                    child: Hero(
                                      transitionOnUserGestures: true,
                                      //tag: "customBackground",
                                      tag: '$index$i',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        //aaaaaaaaaaaa здесь некоторое говно
                                        child: PinchZoom(
                                          image: Image.network(
                                              '${constants.host}/${reports[index]['files'][i]['path']}',fit: BoxFit.fitWidth),
                                          zoomedBackgroundColor:
                                              Colors.black.withOpacity(0.5),
                                          resetDuration:
                                              const Duration(milliseconds: 100),
                                          maxScale: 2.5,
                                          
                                        ),
/*                                         child: new Image.network(
                                          '${constants.host}/${reports[index]['files'][i]['path']}'
                                          , fit: BoxFit.cover,
                                          //height: 200, width: 200,
                                        ), */
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        );
                      }).toList(),
                    ), 
                    Text('${reports[index]['title']}'),
                    Text('${reports[index]['text']}'),
                    Text('${reports[index]['creator']}'),
                    Text('${reports[index]['createdAt'].split(':')[0].replaceAll('T', ' ')}:${reports[index]['createdAt'].split(':')[1]}'),
                  ]),

                  //Text(reports[index].toString()),
                );
              },
              itemCount: count,
            ),
            whenEmptyLoad: false,
            delegate: DefaultLoadMoreDelegate(),
            textBuilder: DefaultLoadMoreTextBuilder.english,
          ),
          onRefresh: _refresh,
        ),
        /* new Column(
          children: <Widget>[ */

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

  Future<bool> _loadMore() async {
    print("onLoadMore");
    Map response = await Request.getReports(nextPage);
    setState(() {
      for (var report in response['docs']) {
        reports.add(report);
      }

      nextPage = response['nextPage'];
      if (!response['hasNextPage']) lengthOfPages = reports.length;
    });
    //await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  Future<void> _refresh() async {
    //await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    reports.clear();
    Map response = await Request.getReports(nextPage);
    setState(() {
      for (var report in response['docs']) {
        reports.add(report);
      }

      //reports = response['docs'];
      nextPage = response['nextPage'];
      lengthOfPages = response['docs'].length * response['totalPages'];
    });
    //load();
  }

  void _onFloatingActionButtonPressed() {}
}
