import 'package:flutter/material.dart';
import 'pdfViewer.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "pdf Viewer app",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("pdf Viewer app"),),
      body: Builder(builder: (context)=>
      Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:
                (context)=>PdfviewerPage()));
              },
              child: Text("view Pdf",
                style: TextStyle(color: Colors.white,fontSize: 20.0),
              ),
              color: Colors.blue,

            )
          ],
        ),
      ),
      ),
      ),
    );
  }
}
