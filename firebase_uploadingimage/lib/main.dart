import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title:'Firebase upload image'),
    );
  }
}

File image;
String filename;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future _getImage() async{
    var selectedImage= await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image=selectedImage;
      //^^24
      filename=basename(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child:  image==null?Text('select an image'): uploadArea(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Increment',
        child: Icon(Icons.image),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget uploadArea(){
  return Column(
    children: <Widget>[
      Image.file(image,width: double.infinity,),
      RaisedButton(
        color: Colors.yellowAccent,
        child: Text('upload'),
        onPressed: (){
          uploadImage();
        },
      )
    ],
  );
}

Future<String> uploadImage() async{
  StorageReference ref=FirebaseStorage.instance.ref().child(filename);
  //^^25
  StorageUploadTask uploadTask= ref.putFile(image);
  //^^24
  var downUrl =await (await uploadTask.onComplete).ref.getDownloadURL();
  var url =downUrl.toString();

  print('Download url;$url');
  return url;
}