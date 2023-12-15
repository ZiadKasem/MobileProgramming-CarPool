import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Add_Ride extends StatefulWidget {
  const Add_Ride({super.key});

  @override
  State<Add_Ride> createState() => _Add_RideState();
}

class _Add_RideState extends State<Add_Ride> {
  late DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child("routes");

  DatabaseReference ref = FirebaseDatabase.instance.ref();
  //TextEditingController fromController = TextEditingController();
  //TextEditingController toController = TextEditingController();
  //TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();


  String selectedTime = "7:30";
  String selectedPickupPoint = "Gate 3";
  String selectedDestination = "Gate 3";


  void _addRoute()async {
    //String from = fromController.text.trim();
    //String to = toController.text.trim();
    //String time = timeController.text.trim();
    String price = priceController.text.trim();
    String? currentDriverid = FirebaseAuth.instance.currentUser?.uid.toString();
    String driverName ='';

    final snapshot = await ref.child('Drivers/$currentDriverid/name').get();
    if (snapshot.exists) {
      driverName = snapshot.value.toString() ;
    } else {
      print('No data available.');
    }


    if (selectedTime.isNotEmpty && selectedPickupPoint.isNotEmpty && selectedDestination.isNotEmpty && price.isNotEmpty) {
      DatabaseReference newRouteRef = _databaseReference.push();
      String? routeID = newRouteRef.key;
      newRouteRef.set({
        'DriverID':currentDriverid,
        'From' : selectedPickupPoint,
        'To'   : selectedDestination,
        'Time' : selectedTime,
        'price': price,
        'DriverName': driverName,
        'TripStatus':"Availabe",
        'RoutID':routeID,
        'numberOfPassengers':'0',
      });

      // Clear the text controllers after adding a route
      //fromController.clear();
      //toController.clear();
      //timeController.clear();
      priceController.clear();
      Navigator.pop(context);

    } else {
      print("One or more fields are empty");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('One or more fields are empty'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add your Ride"),
      ),
      body: Column(
        children: [
          Text('Select Time:'),
          DropdownButton<String>(
            value: selectedTime,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedTime = newValue;
                  selectedPickupPoint = "Gate 3";
                  selectedDestination = "Gate 3";
                });
              }
            },
            items: ['7:30', '17:30'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          SizedBox(height: 20),
          Text(selectedTime == '7:30' ? 'Select Destination:' : 'Enter Destination:'),

          selectedTime == '7:30' ?

          DropdownButton<String>(
            value: selectedDestination,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedDestination = newValue;

                });
              }
            },
            items: ['Gate 3', 'Gate 4'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )

              : TextField(
            onChanged: (value) {
              setState(() {
                selectedDestination = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter destination',
            ),
          ),

          SizedBox(height: 20),
          Text(selectedTime == '7:30' ? 'Enter Pickup Point:' : 'Select Pickup Point:'),

          selectedTime == '7:30'
              ? TextField(
            onChanged: (value) {
              setState(() {
                selectedPickupPoint = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter pickup point',
            ),
          )
              : DropdownButton<String>(
            value: selectedPickupPoint,
            onChanged: (String? newValue) {
              setState(() {
                selectedPickupPoint = newValue!;
              });
            },
            items: <String>['Gate 3', 'Gate 4'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle the logic to save the trip details
              // You can use the selectedTime, selectedPickupPoint, and selectedDestination variables here
              _addRoute();
              print('Time: $selectedTime, Pickup Point: $selectedPickupPoint, Destination: $selectedDestination');

            },
            child: Text('Save Trip'),
          ),

        ],


        /*children: [
          TextField(
            controller: fromController,
            decoration: InputDecoration(labelText: 'From'),
          ),
          TextField(
            controller: toController,
            decoration: InputDecoration(labelText: 'To'),
          ),
          TextField(
            controller: timeController,
            decoration: InputDecoration(labelText: 'Time'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
          ),
          ElevatedButton(
            onPressed: () {
              _addRoute();
              // Adding print statement to check mapRoutes after adding a route
              //print("Updated mapRoutes: $mapRoutes");
            },
            child: Text('Add Route'),
          ),

        ],*/
      ),

    );
  }
}
