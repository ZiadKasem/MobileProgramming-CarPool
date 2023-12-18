import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'Test_file/GlobalVariableForTesting.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPaymentMethod = 'Cash';
  bool _isCashSelected = true;
  late DatabaseReference usereref;
  late DatabaseReference routeref;
  var uid;
  var currentUserEmail;
  late var userdata;



  Future<DataSnapshot> _fetchData(String fun_routeInstanceID) async {
    print("routeInstanceID ${fun_routeInstanceID}");
    currentUserEmail = FirebaseAuth.instance.currentUser?.email.toString();
    print("email ${currentUserEmail}");
    routeref = FirebaseDatabase.instance.ref("routes/$fun_routeInstanceID");
    if(TESTMODE == 1){
      uid = "TEST";
    }else{
      uid = FirebaseAuth.instance.currentUser?.uid.toString();
    }

    usereref = FirebaseDatabase.instance.ref("users/${uid}");
    userdata = await usereref.get();
    var snapshot = await routeref.get();
    return snapshot;

  }


  @override
  Widget build(BuildContext context) {
    Map routeInstanceID = ModalRoute.of(context)!.settings.arguments as Map;
    //_fetchData(routeInstanceID["RoutID"]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: FutureBuilder(
          future: _fetchData(routeInstanceID["RoutID"]),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while waiting for the data
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if there's an error
              return Text('Error: ${snapshot.error}');
            } else {
              // Display your screen content using the fetched data
              // Access the data using snapshot.data
              // For example, assuming you're dealing with a DataSnapshot
              // you can access the data like: snapshot.data.value
              //var data = snapshot.data!.value as Map<String, dynamic>;
              var data = (snapshot.data!.value as Map<Object?, Object?>).cast<String, dynamic>();
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          "Rider name:",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),
                        Text(
                          '${data?["DriverName"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          "PickUp point:",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),
                        Text(
                          '${data?["From"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          "Destination point:",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),
                        Text(
                          '${data?["To"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          "Time:",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),
                        Text(
                          '${data?["Time"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          "Price::",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),
                        Text(
                          '${data?["price"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20 ,
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),

                    Text(
                      "Choose payment Method",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),

                    SizedBox(height: 10,),

                    // RadioListTile option
                    RadioListTile<bool>(
                      title: Text('Cash'),
                      value: true,
                      groupValue: _isCashSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCashSelected = value ?? false;
                          _selectedPaymentMethod = _isCashSelected ? 'Cash' : 'Other';
                        });
                      },
                    ),

                    RadioListTile<bool>(
                      title: Text('Visa'),
                      value: false,
                      groupValue: _isCashSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCashSelected = value ?? true;
                          _selectedPaymentMethod = _isCashSelected ? 'Cash' : 'Visa';
                        });
                      },
                    ),

                    // DropdownButton option
                    SizedBox(height: 10,),



                    SizedBox(height: 20,),

                    ElevatedButton(
                      onPressed: () {
                        // i want to get number of passengers and increment them
                        // then store it back
                        // i want to assign the user to the ride by name passenger #
                        // and value user ID
                        // i want each passenger can reserve only once


                        // Check if the current user ID is already assigned to the route
                        bool isUserAssigned = false;

                        if (data?["TotalPassengersAssigned"] != null) {

                          Map<Object?, Object?>? passengers = data?["TotalPassengersAssigned"];
                          if (passengers!.containsValue(uid)) {
                            isUserAssigned = true;
                          }
                        }

                        if (!isUserAssigned) {

                          if(data?["TripStatus"] == "FullyBooked"){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('this trip is FullyBooked'),
                              ),
                            );
                          }else{
                              var counter =data?["numberOfPassengers"] ;
                              counter  = int.parse(counter);
                              counter=counter+1;
                              // If the user is not assigned, proceed to add the user as a new passenger
                              routeref.child("TotalPassengersAssigned").update({uid:uid});
                              routeref.child("Passengers").update({"${userdata.child("name").value},${userdata.child("phone").value}":"${userdata.child("name").value},${userdata.child("phone").value}"});//store user name and phone
                              /*usereref.child("assignedToTrip")
                                  .child(routeInstanceID["RoutID"]).set(routeInstanceID["RoutID"]);*/
                              Navigator.pop(context);
                          }
                        } else {
                          // If the user is already assigned, you can show a message or take appropriate action
                          // For example, show a snackbar with a message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You have already reserved this route.'),
                            ),
                          );
                        }
                      },
                      child: Text('Proceed to Payment'),

                    ),
                  ],
                ),
              );

          }

          }
      ),
    );
  }
}
