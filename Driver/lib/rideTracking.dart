import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RideTracking extends StatefulWidget {
  const RideTracking({Key? key});

  @override
  State<RideTracking> createState() => _RideTrackingState();
}

class _RideTrackingState extends State<RideTracking> {
  late DatabaseReference routeref;

  DatabaseReference userref = FirebaseDatabase.instance.ref("users");
  var driverID;
  var usersnapshot;





  Future<DataSnapshot> _fetchData(String routeInstanceID) async {
    driverID = FirebaseAuth.instance.currentUser?.uid.toString();
    routeref = FirebaseDatabase.instance.ref("routes/$routeInstanceID");

    usersnapshot = await userref.get();
    var snapshot = await routeref.get();


    return snapshot;

  }


  @override
  Widget build(BuildContext context) {
    Map routeInstanceID = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text("Review your Ride"),
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

              /*
              * hna ana bgeb al Data 3ady
              * b3d kda b3ml list of userIDs aly 3mlo request ll ride
              * wbgeb map mn kl al users aly 3and
              *
              * */




              var data = (snapshot.data!.value as Map<Object?, Object?>).cast<String, dynamic>();

              var passengersMap = Map<String, dynamic>.from(data?["Passengers"]);
              // Create an empty list to store the values
              List<dynamic> passengersList = [];

              // Add all values from the map to the list
              passengersList.addAll(passengersMap.values);

              var usersData = (usersnapshot.value as Map<Object?, Object?>).cast<String, dynamic>();
              
              print(usersData);




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

                    Text('Status: ${data?["TripStatus"] ?? "N/A"}'),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                              onPressed: ()async{
                                await routeref.child("TripStatus").set("Started");
                                setState(() {

                                });
                              },
                              child: Text("Start Ride")
                          ),

                        ElevatedButton(
                            onPressed: ()async{
                              if(data?["TripStatus"] == "Started"){
                                await routeref.child("TripStatus").set("Ended");
                                setState(() {
                                });
                              }
                              else{

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('You can\'t End the ride before it started'),
                                  ),
                                );
                              }

                            },
                            child: Text("End Ride")
                        ),

                        ElevatedButton(
                            onPressed: ()async{
                              if(data?["TripStatus"] == "Started") {



                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('You can\'t Cancel the ride During the Trip'),
                                  ),
                                );



                              }
                              else if(data?["TripStatus"] == "Available"){

                              await routeref.child("TripStatus").set("Canceled");
                              setState(() {});

                              }
                              else if(data?["TripStatus"] == "Ended"){
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                              content: Text('You can\'t Cancel the ride after the Trip Endded'),
                              ),
                              );
                              }
                            },
                            child: Text("Cancel Ride")
                        ),


                      ],
                    ),


                   Expanded(
                      child:SizedBox.expand(
                        child: ListView.builder(
                          itemCount: passengersList.length,
                          itemBuilder: (context,index){
                            return Container(
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: Colors.blueAccent,
                              ),
                              //color: Colors.blueAccent,
                              margin: EdgeInsets.fromLTRB(1, 1, 1, 10),
                              child: ListTile(
                                title: Column(
                                  children: [
                                    Text("name:${usersData[passengersList[index]]["name"]}"),


                                    ],
                                ),
                              subtitle: Text("phone:${usersData[passengersList[index]]["phone"]}"),
                              leading: ElevatedButton(
                                onPressed: (){},
                                child: Text("Accept",style: TextStyle(fontSize: 10.0),),
                              ),
                              trailing: ElevatedButton(
                                onPressed: (){},
                                child: Text("Reject",style: TextStyle(fontSize: 10.0),),

                              ),


                              ),
                            );

                          },
                        ),
                      ),
                    ),






                    /*DropdownButton<String>(
                      value: selectedStatus,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedStatus = newValue;
                          });
                        }
                      },
                      items: ['completed','In service','Available','canceled','Fully booked'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),*/


                    /*
                    * thoughts
                    * driver change status (completed / In service / Available / canceled / Fully booked )
                    * now i need to add expanded wigdet
                    * has recycle view that contains passengers apply for the trip
                    * each tile will have passenger name, mobile -button for accept/reject
                    * when accepting the passenger create new node called acceptedPassengers
                    * */
                  ],
                ),
              );

            }// end of the else statement

          }
      ),
    );
  }
}
