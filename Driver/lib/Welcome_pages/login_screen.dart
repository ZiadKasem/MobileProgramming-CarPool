import 'package:flutter/material.dart';
import 'package:driver_app/Welcome_pages/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:driver_app/reusable/reusable_methods.dart';
import 'package:driver_app/Authentication/authentication_class.dart';

import '../Test_file/GlobalVariableForTesting.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  ReusableMethods rMethods = ReusableMethods();
  Authentication_class AUTH = Authentication_class();
  bool isLoading = false; // Add a loading indicator variable
  bool _obscureText = true;

  checkIfNetworkIsAvailable() {
    rMethods.checkConnectivity(context);
    logInFormValidation();
  }

  logInFormValidation() {
    if (!emailTextEditingController.text.endsWith("@eng.asu.edu.eg")) {
      rMethods.displaySnakBar("Please SignUp with ASU Domain Email", context);
    } else if (passwordTextEditingController.text.trim().length < 6) {
      rMethods.displaySnakBar(
          "Password Must Be At Least 6 Characters", context);
    } else {
      if (emailTextEditingController.text == "test@eng.asu.edu.eg") {
        TESTMODE = 1;
        Navigator.pushReplacementNamed(context, '/home_screen');
      } else {
        TESTMODE = 0;
        print("TESTMODE = 0");
        LogInUser();
      }
    }
  }

  LogInUser() async {
    setState(() {
      isLoading = true; // Set loading to true before starting the login process
    });

    await AUTH
        .Log_in(emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim(), context)
        .whenComplete(() {
      setState(() {
        isLoading = false; // Set loading to false when the login process is complete
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/car-sharing.png",
                  width: 170,
                ),
                SizedBox(height: 25,),
                Text(
                  "Welcome to Ainshams CarPool",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Driver: Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "User Email",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 30,),

            TextField(
              controller: passwordTextEditingController,
              keyboardType: TextInputType.text,
              obscureText: _obscureText, // Use the state variable
              decoration: InputDecoration(
                labelText: "User Password",
                labelStyle: TextStyle(
                  fontSize: 14,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
                SizedBox(height: 30,),
                ElevatedButton(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    checkIfNetworkIsAvailable();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 80),
                  ),
                ),
                SizedBox(height: 30,),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (c) => SignUpScreen()));
                  },
                  child: Text(
                    "Don't have an account? Signup Here",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
