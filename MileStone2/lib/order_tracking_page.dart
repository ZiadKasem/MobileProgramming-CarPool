import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {

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
    uid = FirebaseAuth.instance.currentUser?.uid.toString();
    routeref = FirebaseDatabase.instance.ref("routes/$fun_routeInstanceID");
    usereref = FirebaseDatabase.instance.ref("users/${uid}");
    userdata = await usereref.get();
    var snapshot = await routeref.get();



    return snapshot;

  }



  @override
  Widget build(BuildContext context) {
    Map routeInstanceID = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("OrderTrackingPage"),
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

              List<dynamic> acceptedPassengersList = [];
              if (data["acceptedPassengers"].toString() == "null"){
                print("No accepted passengers yet");

              }
              else{
                var acceptedPassengersListMap = Map<String, dynamic>.from(data["acceptedPassengers"]);
                // Add all values from the map to the list
                acceptedPassengersList.addAll(acceptedPassengersListMap.values);
                //print(acceptedPassengersList);
              }


              List<dynamic> rejectedPassengersList = [];
              if (data["rejectedPassengers"].toString() == "null"){
                print("No accepted passengers yet");

              }
              else{
                var rejectedPassengersListMap = Map<String, dynamic>.from(data["rejectedPassengers"]);
                // Add all values from the map to the list
                rejectedPassengersList.addAll(rejectedPassengersListMap.values);
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
                            fontSize: 15 ,
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
                            fontSize: 15,
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
                            fontSize: 15 ,
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
                            fontSize: 15,
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

                    rejectedPassengersList.isEmpty ? Text("NO rejected passengers yet"):
                    Expanded(
                      child:SizedBox.expand(
                        child: ListView.builder(
                          itemCount: rejectedPassengersList.length,
                          itemBuilder: (context,index){
                            return Container(

                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(45),
                                color: Colors.red,
                              ),
                              margin: EdgeInsets.fromLTRB(1, 1, 1, 10),

                              child: ListTile(
                                title: Column(
                                  children: [
                                    Text(rejectedPassengersList[index].toString().split(",")[1].split("}")[0]),
                                  ],
                                ),
                                subtitle: Text(rejectedPassengersList[index].toString().split(",")[0].split("{")[1]),

                              ),
                            );
                          },
                        ),
                      ),
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
