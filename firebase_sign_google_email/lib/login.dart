import 'package:firebasesigngoogleemail/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController=TextEditingController(text: '');
    _passwordController=TextEditingController(text: '');

  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100.0,),
              Text('Log in',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                child: Text('Login with google'),
                onPressed: () async{
                  AuthProvider().loginWithGoogle;
//                 if(!res)
//                   print('error login with google');
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter email'
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Enter password'
                ),
              ),

              SizedBox(height: 10.0,),
              RaisedButton(
                child: Text('Login'),
                onPressed: ()async{
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
                    print('both of them are empty');
                    return;
                  }
                 bool res=await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
                  if(!res){
                    print('log in failed');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
