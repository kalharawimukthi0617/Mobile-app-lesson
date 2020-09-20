//import 'package:flutter/material.dart';
//
//import 'dateTime.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//
//        primarySwatch: Colors.blue,
//
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: DateTimeComboLinePointChart(),
//    );
//  }
//}


////////////////////////////

import 'package:flutter/material.dart';
//import 'app_config.dart';
import 'home.dart';

/// The main gallery app widget.
class GalleryApp extends StatefulWidget {
  GalleryApp({Key key}) : super(key: key);

  @override
  GalleryAppState createState() => new GalleryAppState();
}

/// The main gallery app state.
///
/// Controls performance overlay, and instantiates a [Home] widget.
class GalleryAppState extends State<GalleryApp> {
  // Initialize app settings from the default configuration.
  bool _showPerformanceOverlay = defaultConfig.showPerformanceOverlay;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        showPerformanceOverlay: _showPerformanceOverlay,
        home: new DateTimeComboLinePointChart());
  }
}

void main() {
  runApp(new GalleryApp());
}