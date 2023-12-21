import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';
import 'package:project/Welcome_pages/login_screen.dart';

import '../Test_file/GlobalVariableForTesting.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
          //if user loggedin
            if(snapshot.hasData && TESTMODE == 0){
              print("TESTMODE EQUAL 0");
              return  MyScreen();
            }
            else{
              return  LoginScreen();
            }

          },
      )
    );
  }
}
