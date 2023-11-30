import 'package:driver_app/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


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
      home: MyScreen(),
      routes: {
        //'/Login_screen': (context) => LoginScreen(),
        //'/Profile_screen': (context) => ProfileScreen(),
        //'/OrderHistory_screen': (context) => OrderHistoryScreen(),
        //'/UpcommingRides_screen':(context) => UpcommingRides(),
        //'/OrderTracking_screen':(context) => OrderTracking(),
        //'/Cart_screen':(context) => CartScreen(),
        '/home_screen':(context) => MyScreen(),
      },
    );
  }
}