import 'package:flutter/material.dart';
import 'package:project/home_screen.dart';
import 'package:project/signup_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
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
                  "Login",
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
                //signup button
                ElevatedButton(
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white,),
                  ),
                  onPressed:(){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (c)=>MyScreen()));
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
