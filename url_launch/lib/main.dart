import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Url_launcher(),
    );
  }
}
class Url_launcher extends StatefulWidget {
  @override
  _Url_launcherState createState() => _Url_launcherState();
}

class _Url_launcherState extends State<Url_launcher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Url..'),

      ),
      body: RaisedButton(
        color: Colors.lightGreenAccent,
        child: Text('Update',),
        onPressed: (){
          openurl();
        },
      ),
    );
  }
  openurl(){
    launch('https://firebasestorage.googleapis.com/v0/b/ol-ict.appspot.com/o/Grade%2010-08.12%2F6lesson_part1.pdf?alt=media&token=d5fe6a10-68ce-46ca-8ea8-d3b279c305c6');
  }
}
