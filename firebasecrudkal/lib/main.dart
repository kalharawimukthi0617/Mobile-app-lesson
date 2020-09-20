import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Firestore firestore=Firestore.instance;
      void _create() async {
        try{
          await firestore.collection('users').document('test').setData({
            'firstName': 'test',
            'lastName': 'user',
          });
        }catch(e){
          print(e);
        }
      }

      void _read() async {
        DocumentSnapshot documentSnapshot;
        try{
          documentSnapshot = await firestore.collection('users').document('test').get();
          print(documentSnapshot.data);
        }catch(e){
          print(e);
        }
      }

      void _update() async {
        try{
          firestore.collection('users').document('test').updateData({
            'firstName': 'testUpdated'
          });
        }catch(e){
          print(e);
        }
      }

      void _delete() async {
        try{
          firestore.collection('users').document('test').delete();
        }catch(e){
          print(e);
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Create'),
              onPressed: _create,
            ),
            RaisedButton(
              child: Text('Read'),
              onPressed: _read,
            ),
            RaisedButton(
              child: Text('Update'),
              onPressed: _update,
            ),
            RaisedButton(
              child: Text('delete'),
              onPressed: _delete,
            )
          ],
        ),
      ),
    );
  }
}

