import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/dashboard.dart';

import 'loging_page.dart';

class AuthService{
  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData){
          return DashboardPage();
        }
        else{
          return LoginPage();
        }
      },
    );
  }
  //signIn

  signIn(AuthCredential authCreds){
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  //signOut
  signOut(){
    FirebaseAuth.instance.signOut();
  }
  signInWithOTP(smsCode,verId) {
    AuthCredential authCreds=PhoneAuthProvider.getCredential(
        verificationId: null,
        smsCode: null);
    signIn(authCreds);
  }
}