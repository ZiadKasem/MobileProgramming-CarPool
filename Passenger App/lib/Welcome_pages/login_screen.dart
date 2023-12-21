import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';
import 'package:project/Welcome_pages/signup_screen.dart';
import '../Authentication/authentication_class.dart';
import '../Test_file/GlobalVariableForTesting.dart';
import '../reusable/reusable_methods.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  ReusableMethods rm = ReusableMethods();
  Authentication_class AUTH = Authentication_class();
  bool _obscureText = true;
  bool isLoading = false;

  checkIfNetworkIsAvailabe(){
    rm.checkConnectivity(context);
    logInFormValidation();
  }

  logInFormValidation(){
    if(!emailTextEditingController.text.endsWith("@eng.asu.edu.eg")){// try to find method to check last few digits
      rm.displaySnakBar("Please Login with ASU Domain Email", context);
    }
    else if(passwordTextEditingController.text.trim().length<6){
      rm.displaySnakBar("Password Must Be Atleast 6 Charachters", context);
    }
    else{
      if(emailTextEditingController.text == "test@eng.asu.edu.eg"){// used to bypass the authentication --for the aid of testing
        TESTMODE = 1;
        print("entering TestMode");
        Navigator.pushReplacementNamed(context,'/home_screen');
      }
      else
        TESTMODE = 0;
        print("TESTMODE = 0");
        LogInUser();
    }

  }

  LogInUser()async{


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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Passenger Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                //emailTextField
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "User Email",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      )
                  ),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 30,),
                //passTextField
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
                //Login button
                ElevatedButton(
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white,),
                  ),
                  onPressed:(){
                    checkIfNetworkIsAvailabe();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 80,)
                  ),
                ),
                //having an account navigate to login Screen
                SizedBox(height: 30,),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (c)=>SignUpScreen()));
                  },
                  child: Text(
                    "Don\'t have an account? Signup Here",
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




    );;
  }
}
