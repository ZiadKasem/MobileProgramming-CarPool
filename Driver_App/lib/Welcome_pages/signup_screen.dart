import 'package:driver_app/Authentication/authentication_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/reusable/reusable_methods.dart';
import '../home_screen.dart';
import 'package:driver_app/Welcome_pages/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController passwordConfirmationTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  ReusableMethods rMethods = ReusableMethods();
  Authentication_class AUTH = Authentication_class();
  bool isLoading = false; // Add a loading indicator variable

  checkIfNetworkIsAvailabe(){
    rMethods.checkConnectivity(context);
    signUpFormValidation();
  }

  signUpFormValidation(){
    if(nameTextEditingController.text.trim().length<3){
      rMethods.displaySnakBar("Name Must Be Atleast 4 charachters", context);
    }
    else if(phoneTextEditingController.text.trim().length<11){
      rMethods.displaySnakBar("Phone Number Must Be Atleast 11 Digets", context);
    }
    else if(!emailTextEditingController.text.endsWith("@eng.asu.edu.eg")){// try to find method to check last few digits
      rMethods.displaySnakBar("Please SignUp with ASU Domain Email", context);
    }
    else if(emailTextEditingController.text == "test@eng.asu.edu.eg"){// try to find method to check last few digits
      rMethods.displaySnakBar("you can't sign in with this mail", context);
    }
    else if(passwordTextEditingController.text.trim().length<6){
      rMethods.displaySnakBar("Password Must Be Atleast 6 Charachters", context);
    }
    else if(passwordConfirmationTextEditingController.text.trim() != passwordTextEditingController.text.trim()){
      rMethods.displaySnakBar("Confirm password is not the same", context);
    }
    else{
      registerNewUser();
    }

  }
  registerNewUser() async {
    setState(() {
      isLoading = true; // Set loading to true before starting the login process
    });


   await AUTH.Sign_up(emailTextEditingController.text.trim(),
        passwordTextEditingController.text.trim(),
        nameTextEditingController.text.trim(),
        phoneTextEditingController.text.trim(),
        context).whenComplete(() {
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
                  "Driver Signup",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //NameTextField
                TextField(
                  controller: nameTextEditingController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "User Name",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      )
                  ),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),

                SizedBox(height: 5,),
                TextField (
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      labelText: "User Phone number",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      )
                  ),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5,),
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
                SizedBox(height: 5,),
                //passTextField
                TextField (
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true, // to hide password
                  decoration: const InputDecoration(
                      labelText: "User Password",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      )
                  ),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5,),
                //passTextField
                TextField (
                  controller: passwordConfirmationTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true, // to hide password
                  decoration: const InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(
                        fontSize: 14,
                      )
                  ),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 5,),
                //phone number

                //signup button

                ElevatedButton(

                  child: isLoading
                      ? CircularProgressIndicator():
                  Text(
                    "Sign Up",
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
                SizedBox(height: 5,),
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (c)=>LoginScreen()));
                  },
                  child: Text(
                    "Already have an account? Login Here",
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
