import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/cart_screen.dart';
import 'package:project/home_screen.dart';
import 'package:project/Welcome_pages/login_screen.dart';
import 'package:project/order_history.dart';
import 'package:project/order_tracking_page.dart';
import 'package:project/profile.dart';


import 'Authentication/auth.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(


        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: AuthPage(),
      routes: {
        '/Login_screen': (context) => LoginScreen(),
        '/Profile_screen': (context) => ProfileScreen(),
        '/OrderHistory_screen': (context) => OrderHistoryScreen(),
        '/Cart_screen':(context) => CartScreen(),
        '/home_screen':(context) => MyScreen(),
        '/order_tracking_page':(context) => OrderTrackingPage(),
      },
    );
  }
}


