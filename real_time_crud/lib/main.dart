import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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
      home: Realtime(),
    );
  }
}
class Realtime extends StatelessWidget {
  final DBRef =FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Androidmonks'),),
      body: Column(
        children: [
          RaisedButton(
            child: Text("Write data"),
            onPressed: (){
              writeData();
            },
          ),
          RaisedButton(
            child:Text('Read data'),
            onPressed: (){
              readeData();
            },
          ),

          RaisedButton(
            child: Text('Update data'),
            onPressed: (){
              updateData();
            },
          ),

          RaisedButton(
            child: Text('Delete'),
            onPressed: (){
              delete();
            },
          ),

        ],
      ),
    );
  }
  void writeData(){
    DBRef.child("1").set({
      'id':'ID1',
      'data':'This is a sample Data',
    });
  }

  void readeData(){
    DBRef.once().then((DataSnapshot dataSnapShot){
      print(dataSnapShot.value);
    });
  }

  void updateData(){
    DBRef.child("1").update({
      'data':'This is a updae value'
    });
  }

  void delete(){
    DBRef.child("1").remove();
  }
}
