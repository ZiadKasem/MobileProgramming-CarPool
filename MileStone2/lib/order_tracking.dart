import 'package:flutter/material.dart';
class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track your ride"),
      ),
      body: Container(

        margin: EdgeInsets.all(10),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/avatarman.png'),
            ),

            SizedBox(height: 20,),

            Text(
                "Rider name: Ahmed Mahmoud",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "PickUp point: Gate 3",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Destination point: Abbaseya square.",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Trip Status: OnTime",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Price: 10EGP",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

          ],
        ),



      ),

    );
  }
}
