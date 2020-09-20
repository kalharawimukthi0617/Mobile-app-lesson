import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging _firebaseMessaging=FirebaseMessaging();

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
      home: Notification(),
    );
  }
}

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {

  @override
  void initState() {

    super.initState();
    setNotification();
  }

  void setNotification() async{
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
    _firebaseMessaging.configure(
        onMessage: (Map<String,dynamic> message)async{
        print('Message :+$message');
      },

        onResume: (Map<String,dynamic> message)async{
      print('Message :+$message');
    },

        onLaunch: (Map<String,dynamic> message)async{
      print('Message :+$message');
    }

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: (){
           
          },
          child: Text('Click'),
        ),
      ),
    );
  }
}

