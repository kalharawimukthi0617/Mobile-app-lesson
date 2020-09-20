import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'homeScreen.dart';
import 'log_in_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password;

  var _formkey=GlobalKey<FormState>();

  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: isLoading ?Center(child: CircularProgressIndicator()):Container(
        margin: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Center(
          child: Form(
           key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (item){
                    return item.contains('@')?null:'Enter valid email';
                  },
                  onChanged: (item){
                    setState(() {
                      _email=item;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  validator: (item){
                    return item.length>6
                        ?null
                        :'Password must be 6 characters';

                  },
                  onChanged: (item){
                    setState(() {
                      _password=item;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      labelText: 'Email',
                      border: OutlineInputBorder()
                  ),

                ),
                SizedBox(height: 20.0,),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: (){
                      signUp();
                    },child: Text('Register',style: TextStyle(color: Colors.red),),
                  ),

                ),
                SizedBox(height: 20.0,),
                Container(child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (_)=> loginScreen()));
                  },
                    child: Text("login here")),alignment: Alignment.centerRight,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void signUp(){
  if(_formkey.currentState.validate()){
    setState(() {
      isLoading=true;
    });
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _email,
        password: _password)
        .then((user) {
          setState(() {
            isLoading=false;
          });

          Fluttertoast.showToast(msg: 'Register Success');

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(_) => HomeScreen()), (Route<dynamic> route) =>false);
    }).catchError((onError){
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(msg: 'error'+onError.toString());
    });
  }
  }
}
