import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_shadow/icon_shadow.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:image_gallery/image_gallery.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/toast.dart';
import '../main.dart';

class MapsPage extends StatefulWidget {
  MapsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MapsPageState createState() => new _MapsPageState();
}

//String data = matches.forEach((key) => print(str.substring(key.start, key.end)));

Widget _regExpAddress(data, fontSize) {
  RegExp exp = RegExp(r'name="(.+?)"');
  return Text(
    '${exp.stringMatch(data).toString().replaceAll('name="', '').replaceAll('"', '').replaceAll('&quot', '').split(', Белореченский район')[0]}',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: fontSize),
  );
}

String _address = '';
bool _activePointer = false;
Map coordinatesOfMarkers = {'x': 44.7555, 'y': 39.8491};
List<Marker> markersList = [
  Marker(
    width: 220.0,
    height: 220.0,
    point: LatLng(44.7555, 39.8491),
    builder: (ctx) => Container(
        child: Column(children: [
      Icon(
        Icons.place_rounded,
        size: 36,
        color: Colors.red,
      ),
      Text(
        ' _regExpAddress(_address)',
        textAlign: TextAlign.center,
        style: TextStyle(),
      )
    ])),
  ),
  Marker(
    width: 320.0,
    height: 320.0,
    point: LatLng(44.7666, 39.8491),
    builder: (ctx) => Container(
        child: Column(children: [
      Icon(
        Icons.place_rounded,
        size: 36,
        color: Colors.red,
      ),
      Text(
        '${''}',
        textAlign: TextAlign.center,
        style: TextStyle(),
      )
    ])),
  )
];

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  } //https://www.openstreetmap.org/geocoder/search_osm_nominatim_reverse?lat=44.77372&lon=39.88068&zoom=18&minlon=39.879518151283264&minlat=44.772520823702195&maxlon=39.88180339336396&maxlat=44.774859039710336

  FToast fToast;
  File _image;
  List<File> _imagesList = [];
  final picker = ImagePicker();

  Future getImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imagesList.add(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> loadImageList() async {
    List allImageTemp;
    allImageTemp = await FlutterGallaryPlugin.getAllImages;

    setState(() {
      this._imagesList = allImageTemp;
    });
  }

  @override //_getAddressFromHtml(_address)
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new FlutterMap(
          options: new MapOptions(
              center: new LatLng(44.7664, 39.8531),
              zoom: 13.0,
              onTap: (polyline) async => {
                    setState(() {
                      coordinatesOfMarkers = {
                        'x': polyline.latitude,
                        'y': polyline.longitude
                      };
                    }),
                    _address =
                        await _getStreet(polyline.latitude, polyline.longitude),
                    setState(() {
                      _address = _address;
                    })
                  }), //13/44.7664/39.8531
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(
              markers: markersList,
              //rebuild: markersList
            ),
            new MarkerLayerOptions(
              markers: [
                Marker(
                    width: 45.0,
                    height: 45.0,
                    point: LatLng(
                        _activePointer ? coordinatesOfMarkers['x'] : 0,
                        _activePointer ? coordinatesOfMarkers['y'] : 0),
                    builder: (ctx) => Container(
                          child: Container(
                              //color: Colors.red,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                _activePointer
                                    ? IconShadowWidget(
                                        Icon(
                                          Icons.filter_tilt_shift_rounded,
                                          size: 36,
                                          color: Colors.blue,
                                        ),
                                        shadowColor: Colors.blue.shade300,
                                      )
                                    : null,
/*                     Text(
                      '${coordinatesOfMarkers['x']}',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ) */
                              ])),
                        ))
              ],
              //rebuild: markersList
            ),
          ],
        )),
        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _activePointer
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: new BorderRadius.circular(25.0)),
                      padding: EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 25, left: 25),
                      child: _regExpAddress(_address, 16.0),
                    )
                  : SizedBox(),
              !_activePointer
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        // Add your onPressed code here!
                        addNewFlag();
                      },
                      focusColor: Colors.red,
                      label: Text('Обозначить нарушение'),
                      icon: Icon(Icons.flag),
                      backgroundColor: Colors.blue,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            // Add your onPressed code here!
                            acceptNewFlag();
                          },
                          focusColor: Colors.red,
                          label: Text('Применить точку'),
                          icon: Icon(Icons.done),
                          backgroundColor: Colors.blue,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            // Add your onPressed code here!
                            cancelFlagPoin();
                          },
                          focusColor: Colors.red,
                          label: Text('Отмена'),
                          icon: Icon(Icons.cancel_rounded),
                          backgroundColor: Colors.orange,
                        ),
                      ],
                    )
            ]));
  }

  void addNewFlag() {
    setState(() {
      _activePointer = true;
    });
    MyToast.show("Укажите с помощью флага место нарушения");
  }

  void acceptNewFlag() {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      //isCloseButton: false,
      //isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.blue,
      ),
      alertAlignment: Alignment.center,
    );
    Alert(
        context: context,
        style: alertStyle,
        title: "Создание заявки:",
        content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: _regExpAddress(_address, 14.0)),
                SizedBox(height: 12),
                Text('Данный объект:',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                SizedBox(height: 8),
/*                 ToggleSwitch(
                  minHeight: 45,
                  minWidth: 110.0,
                  initialLabelIndex: 1,
                  cornerRadius: 25.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  fontSize: 14,
                  labels: ['Нелегален', 'Ветхий'],
                  //icons: [Icon(Icons.ac_unit), Icon(Icons.ac_unit)],
                  activeBgColors: [Colors.blue, Colors.blue],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ), */
                SizedBox(height: 8),
                //_imagesList.length > 0 ? Image.file(_image,fit: BoxFit.fitHeight) : null,

/*                 _image == null
                    ? Text('No image selected.')
                    : Image.file(_image), */
/*                 LiteRollingSwitch(
                  //initial value

                  value: false,
                  textOn: 'Ветхий',
                  textOff: 'Нелегален',
                  colorOn: Colors.orangeAccent[700],
                  colorOff: Colors.redAccent[700],
                  iconOn: Icons.done,
                  iconOff: Icons.remove_circle_outline,
                  textSize: 24.0,
                  
                  onChanged: (bool state) {
                    //Use it to manage the different states
                    print('Current State of SWITCH IS: $state');
                  },
                ), */
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RadioButton(
                      description: "Имеет ветхое состояние",
                      value: "Имеет ветхое состояние",
                      groupValue: "Имеет ветхое состояние",
                      onChanged: (value) => setState(
                        () => print('object'),
                      ),
                    ),
                    //Text('-или-', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    RadioButton(
                      description: "Не зарегистрирован",
                      value: "Не зарегистрирован",
                      groupValue: "Text alignment left",
                      onChanged: (value) => setState(
                        () => print('object'),
                      ),
                      //textPosition: RadioButtonTextPosition.left,
                    ),
                    SizedBox(height: 16),
                    _imagesList.length <= 0
                        ? Container(
                            child: InkWell(
                                onTap: () => getImage(),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo_rounded,
                                          color: Colors.blue),
                                      Text('  Добавить фото',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.blue))
                                    ])))
                        : Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                for (var image in _imagesList)
                                  InkWell(
                                    onTap: () => print('ddd'),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    25.0)),
                                        width: 56,
                                        height: 56,
                                        child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Image.file(image,
                                                  fit: BoxFit.cover),
                                              Icon(
                                                Icons.close_rounded,
                                                size: 36,
                                                color: Colors.white,
                                              )
                                            ])),
                                  ),
                                InkWell(
                                    onTap: () => getImage(),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      color: Colors.blue,
                                      child: Icon(
                                        Icons.add_a_photo_rounded,
                                        size: 36,
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                            ),
                          ),
/*                     FlatButton(
                        onPressed: () => getImage(),
                        child: Container(
                            height: 45,
                            //width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: new BorderRadius.circular(25.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attach_file,
                                    color: Colors.white,
                                  ),
                                  Text('Добавить фото',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))
                                ]))), */
                  ],
                ),
                Container(
                    //width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                  decoration: InputDecoration(
                    //icon: Icon(Icons.description),
                    labelText: 'Описание',
                  ),
                )),
              ],
            )),
        buttons: [
          DialogButton(
            radius: new BorderRadius.circular(25.0),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Принять",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
/*           DialogButton(
            color: Colors.blueGrey,
            width: 125,
            //height: 100,
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.attach_file, color: Colors.white),
          ), */
        ]).show();
  }

  Future<String> _getStreet(lat, lon) async {
    var url =
        'https://www.openstreetmap.org/geocoder/search_osm_nominatim_reverse?lat=$lat&lon=$lon&zoom=18&minlon=$lon&minlat=$lat&maxlon=$lon&maxlat=$lat';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }

  Widget _getAddressFromHtml(data) {
    Widget html = Html(
      data: data,
      //Optional parameters:
      //backgroundColor: Colors.white70,
      onLinkTap: (url) {
        // open url in a webview
      },
/*       style: {
        "div": Style(
          block: Block(
            margin: EdgeInsets.all(16),
            border: Border.all(width: 6),
            backgroundColor: Colors.grey,
          ),
          textStyle: TextStyle(
            color: Colors.red,
          ),
        ),
      }, */
      onImageTap: (src) {
        // Display the image in large form.
      },
    );
    return html;
  }

  void cancelFlagPoin() {
    setState(() {
      _activePointer = false;
    });
    MyToast.show("Отменено");
  }
}
