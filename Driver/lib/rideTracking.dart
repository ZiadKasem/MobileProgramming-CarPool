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






  Future<DataSnapshot> _fetchData(String routeInstanceID) async {

    routeref = FirebaseDatabase.instance.ref("routes/$routeInstanceID");
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

              var data = (snapshot.data!.value as Map<Object?, Object?>).cast<String, dynamic>();
              // Create an empty list to store the values
              List<dynamic> passengersList = [];
              List<dynamic> acceptedPassengersList = [];



              if (data["Passengers"].toString() == "null"){
                print("No passengers yet");

              }
              else{
              var passengersMap = Map<String, dynamic>.from(data["Passengers"]);
              // Add all values from the map to the list
              passengersList.addAll(passengersMap.values);
              print("before ${passengersList}");
              }

              if (data["acceptedPassengers"].toString() == "null"){
                print("No accepted passengers yet");

              }
              else{
                var acceptedPassengersListMap = Map<String, dynamic>.from(data["acceptedPassengers"]);
                // Add all values from the map to the list
                acceptedPassengersList.addAll(acceptedPassengersListMap.values);
                //print(acceptedPassengersList);
              }






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
                            fontSize: 15 ,
                          ),
                        ),
                        Text(
                          '${data?["DriverName"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
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
                            fontSize: 15 ,
                          ),
                        ),
                        Text(
                          '${data?["From"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15 ,
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
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${data?["To"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15 ,
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
                            fontSize: 15 ,
                          ),
                        ),
                        Text(
                          '${data?["Time"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15 ,
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
                            fontSize: 15 ,
                          ),
                        ),
                        Text(
                          '${data?["price"] ?? "N/A"}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15 ,
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

                   acceptedPassengersList.isEmpty ? Text("NO accepted passengers yet"):
                   Expanded(
                       child:SizedBox.expand(
                         child: ListView.builder(
                           itemCount: acceptedPassengersList.length,
                           itemBuilder: (context,index){
                             return Container(

                               decoration:BoxDecoration(
                                 borderRadius: BorderRadius.circular(45),
                                 color: Colors.green,
                               ),
                               margin: EdgeInsets.fromLTRB(1, 1, 1, 10),

                               child: ListTile(
                                 title: Column(
                                   children: [
                                     Text(acceptedPassengersList[index].toString().split(",")[1].split("}")[0]),
                                   ],
                                 ),
                                 subtitle: Text(acceptedPassengersList[index].toString().split(",")[0].split("{")[1]),

                               ),
                             );
                           },
                         ),
                       ),
                     ),



                  passengersList.isEmpty ? Text("NO passengers request the ride yet"):
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
                                    Text(passengersList[index].toString().split(",")[0]),
                                    ],
                                ),
                              subtitle: Text(passengersList[index].toString().split(",")[1]),
                              leading: ElevatedButton(// accept button
                                onPressed: (){

                                  if(data?["numberOfPassengers"] != "4"){
                                    var counter =data?["numberOfPassengers"] ;
                                    counter  = int.parse(counter);
                                    counter=counter+1;
                                    routeref.child("numberOfPassengers").set(counter.toString());

                                    routeref
                                        .child("acceptedPassengers")
                                        .child("${passengersList[index].toString()}")
                                        .update({
                                      "name":"${passengersList[index].toString().split(",")[0]}",
                                      "phone":"${passengersList[index].toString().split(",")[1]}",
                                    });
                                    
                                    routeref.child("Passengers").child("${passengersList[index].toString()}").remove();
                                    passengersList.remove(passengersList[index]);
                                    print("after remove ${passengersList}");

                                    if(counter == 4){
                                      routeref.child("TripStatus").set("FullyBooked");
                                    }
                                    setState(() {

                                    });
                                  }else{

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('You already accepted 4 passengers'),
                                      ),
                                    );
                                  }

                                  //remove the accepted from the list and from the node

                                },
                                child: Text("Accept",style: TextStyle(fontSize: 10.0),),
                              ),
                              trailing: ElevatedButton(
                                onPressed: (){
                                  routeref
                                      .child("rejectedPassengers")
                                      .child("${passengersList[index].toString()}")
                                      .update({
                                    "name":"${passengersList[index].toString().split(",")[0]}",
                                    "phone":"${passengersList[index].toString().split(",")[1]}",
                                  });

                                  routeref.child("Passengers").child("${passengersList[index].toString()}").remove();
                                  passengersList.remove(passengersList[index]);
                                  print("after remove ${passengersList}");
                                  setState(() {

                                  });



                                },
                                child: Text("Reject",style: TextStyle(fontSize: 10.0),),

                              ),


                              ),
                            );

                          },
                        ),
                      ),
                    ),




                    /*
                    * when accepting the passenger create new node called acceptedPassengers
                    * accepted passengers appears in the cart / track - pages
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
