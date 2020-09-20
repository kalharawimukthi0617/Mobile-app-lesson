import 'package:flutter/material.dart';

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
      home: TextFieldScreen(),
    );
  }
}

class TextFieldScreen extends StatefulWidget {
  @override
  _TextFieldScreenState createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {

  TextEditingController _controller =TextEditingController();

  String name='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[



              Container(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                decoration: InputDecoration(
                  labelText: 'enter',
                  fillColor: Colors.amber,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.amber,
                          width: 2.0
                      )
                  ),
                ),
                  controller: _controller,
                ),
                padding: EdgeInsets.all(32.0),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text('click'),
                  color: Colors.red,
                  onPressed: (){
                    setState(() {
                      name=_controller.text;
                    });
                  },
                ),
                padding: EdgeInsets.all(32.0),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  height: 100.0,
                  color: Colors.amber,
                  child: SingleChildScrollView(
                    child: ListTile(

                     // title: Text(name),
                      onTap: (){
                        setState(() {
                         // _controller.text=name;
                        });
                      },

                    ),
                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}

