import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';

import '../Welcome_pages/login_screen.dart';
import '../home_screen.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
          //if user loggedin
            if(snapshot.hasData){
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
