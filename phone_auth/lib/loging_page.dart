import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_auth/auth_service.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey =new GlobalKey<FormState>();
  String phoneNo, verificationId,smsCode;
  bool codeSent=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter phone number'),
                onChanged: (val){
                  setState(() {
                    this.phoneNo =val;

                  });

                },
              ),
            ),

            codeSent ? Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(hintText: 'Enter OTP code'),
                onChanged: (val){
                  setState(() {
                    this.smsCode =val;

                  });

                },
              ),
            ):Container(

            ),
            Container(
              child: RaisedButton(
                child: Center(child: codeSent?Text('log in'): Text('verify')),
                onPressed: (){
                 codeSent? AuthService().signInWithOTP(smsCode, verificationId):verifyPhone(phoneNo);
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
  Future<void> verifyPhone(PhoneNo) async{
    final PhoneVerificationCompleted verified =(AuthCredential authResult){
      AuthService().signIn(authResult);
    };
    final PhoneVerificationFailed verificationFailed =(AuthException authException){
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent =(String verId,[int forceResend]){
      this.verificationId=verId;
      setState(() {
        this.codeSent=true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout =(String verId){
      this.verificationId=verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 8),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
