import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';
import '../reusable/reusable_methods.dart';


class Authentication_class {
  ReusableMethods rMethods = ReusableMethods();

  Future<int> Sign_up(String emailTextEditingController
      , String passwordTextEditingController
      , String nameTextEditingController
      , String phoneTextEditingController
      , BuildContext context) async {
    final User? userFirebase = (
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextEditingController,
          password: passwordTextEditingController,
        ).catchError((errorMsg) {
          rMethods.displaySnakBar(errorMsg.toString(), context);
        })
    ).user;
    if (!context.mounted) return 0;

      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child(
          "users").child(userFirebase!.uid);
      Map userDataMap = {
        "name": nameTextEditingController,
        "email": emailTextEditingController,
        "phone": phoneTextEditingController,
        "id": userFirebase.uid,
        "Type": "USER",
        "blockStatus": "no",
      };
      usersRef.set(userDataMap);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => MyScreen()));
      return 0;

  }


    Log_in(String emailTextEditingController
        , String passwordTextEditingController
        , BuildContext context) async {
      final User? userFirebase = (
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailTextEditingController,
            password: passwordTextEditingController,
          ).catchError((errorMsg) {
            rMethods.displaySnakBar(errorMsg.toString(), context);
          })
      ).user;

      if (!context.mounted) return 0;

      if (userFirebase != null) {
        DatabaseReference DriverRef = FirebaseDatabase.instance.ref().child(
            "users").child(userFirebase!.uid);
        DriverRef.once().then((snap) {
          if (snap.snapshot.value != null) {
            if ((snap.snapshot.value as Map)["blockStatus"] == "no") {
              Navigator.pushReplacementNamed(context, '/home_screen');
            }
            else {
              FirebaseAuth.instance.signOut();
              rMethods.displaySnakBar("This Account Is Blocked", context);
            }
          } else {
            FirebaseAuth.instance.signOut();
            rMethods.displaySnakBar("The Account Not Found As User", context);
          }
        });
      }
    }

    Sign_out() async {
      await FirebaseAuth.instance.signOut();
    }

}