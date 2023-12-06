import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';
import 'package:project/login_screen.dart';
import 'package:project/methods/reusable_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  ReusableMethods rMethods = ReusableMethods();

  checkIfNetworkIsAvailabe(){
    rMethods.checkConnectivity(context);
    signUpFormValidation();
  }

  signUpFormValidation(){
    if(nameTextEditingController.text.trim().length<3){
      rMethods.displaySnakBar("Name Must Be Atleast 4 charachters", context);
    }
    else if(!emailTextEditingController.text.endsWith("@eng.asu.edu.eg")){// try to find method to check last few digits
      rMethods.displaySnakBar("Please SignUp with ASU Domain Email", context);
    }
    else if(passwordTextEditingController.text.trim().length<6){
      rMethods.displaySnakBar("Password Must Be Atleast 6 Charachters", context);
    }
    else if(phoneTextEditingController.text.trim().length<11){
      rMethods.displaySnakBar("Phone Number Must Be Atleast 11 Digets", context);
    }
    else{
      registerNewUser();
    }

  }

  registerNewUser()async{
    final User? userFirebase = (
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
    ).catchError((errorMsg){
      rMethods.displaySnakBar(errorMsg.toString(), context);
    })
    ).user;
    if(!context.mounted)return;
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap = {
      "name":nameTextEditingController.text.trim(),
      "email":emailTextEditingController.text.trim(),
      "phone":phoneTextEditingController.text.trim(),
      "id":userFirebase.uid,
      "Type":"USER",
      "blockStatus":"no",
    };
    usersRef.set(userDataMap);

    Navigator.pushReplacement(context,MaterialPageRoute(builder: (c)=>MyScreen()));

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
                  "Signup",
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
                SizedBox(height: 30,),
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
                SizedBox(height: 30,),
                //phone number
                TextField (
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  obscureText: true, // to hide password
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
                SizedBox(height: 30,),
                //signup button

                ElevatedButton(

                  child: const Text(
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
                SizedBox(height: 30,),
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
