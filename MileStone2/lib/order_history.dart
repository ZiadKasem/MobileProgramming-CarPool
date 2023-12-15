
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late DatabaseReference _databaseReference;
  late DatabaseReference _usersAssignedReference;
  List<Map<String, String>> mapRoutes = [];

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child("routes");
    _usersAssignedReference = FirebaseDatabase.instance.ref().child("routes/TotalPassengersAssigned");
    _setupDataListener();
  }

  void _setupDataListener() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        print("Retrieved Data: ${event.snapshot.value}");

        // The retrieved data is a map, convert entries to a list
        var data = (event.snapshot.value as Map<dynamic, dynamic>).entries;

        if (data != null) {
          setState(() {
            mapRoutes = data
                .where((entry) {
              // Filter based on TotalPassengersAssigned for the current user
              var totalPassengersAssigned =
              entry.value['TotalPassengersAssigned'] as Map?;
              return totalPassengersAssigned != null &&
                  totalPassengersAssigned.containsKey(
                      FirebaseAuth.instance.currentUser?.uid);
            })
                .map((entry) =>
            Map<String, String>.from({
              'From': '${entry.value['From']}',
              'To': '${entry.value['To']}',
              'Time': '${entry.value['Time']}',
              'RoutID': '${entry.value['RoutID']}',
              "price": '${entry.value['price']}',
              "TripStatus": '${entry.value['TripStatus']}',
            }))
                .toList();
          });
        }
      } else {
        print("Snapshot value is null");
      }
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order history'),
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text("will implement here search bar"),
            Expanded(
              child: ListView.builder(
                itemCount: mapRoutes.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(

                      color: Colors.blueAccent,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("From:${mapRoutes[index]['From']}",
                              style: TextStyle(fontSize: 12),),
                            Text("Time:${mapRoutes[index]['Time']}"),
                            Text("To:${mapRoutes[index]['To']}"),
                            Text("Status:${mapRoutes[index]["TripStatus"]}"),

                          ],
                        ),
                        leading: Image.asset(
                          "assets/images/car-sharing.png",
                          height: 25,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context,
                              "/order_tracking_page",
                              arguments: {
                                "RoutID": "${mapRoutes[index]['RoutID']}"
                              }
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}