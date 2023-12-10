import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() {
  runApp(MyScreen());
}

class MyScreen extends StatefulWidget {
  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  late DatabaseReference _databaseReference;
  List<Map<String, String>> mapRoutes = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child("routes");
    _setupDataListener();
  }

  void _setupDataListener() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        print("Retrieved Data: ${event.snapshot.value}");

        // The retrieved data is a map, convert entries to a list
        var data = (event.snapshot.value as Map<dynamic, dynamic>)?.entries;

        if (data != null) {
          setState(() {
            mapRoutes = data
                .map((entry) => Map<String, String>.from({
              'From': '${entry.value['From']}',
              'To': '${entry.value['To']}',
              'Time': entry.value['Time'],
            }))
                .toList();
          });
        }
      } else {
        print("Snapshot value is null");
      }
    });
  }


  void _addRoute()async {
    String from = fromController.text.trim();
    String to = toController.text.trim();
    String time = timeController.text.trim();
    String price = priceController.text.trim();
    String? currentDriverid = FirebaseAuth.instance.currentUser?.uid.toString();
    String driverName ='';

    final snapshot = await ref.child('Drivers/$currentDriverid/name').get();
    if (snapshot.exists) {
      driverName = snapshot.value.toString() ;
    } else {
      print('No data available.');
    }


    if (from.isNotEmpty && to.isNotEmpty && time.isNotEmpty && price.isNotEmpty) {
      DatabaseReference newRouteRef = _databaseReference.push();
      String? routeID = newRouteRef.key;
      newRouteRef.set({
        'From' : from,
        'To'   : to,
        'Time' : time,
        'price': price,
        'DriverName': driverName,
        'Trip Status':"Availabe",
        'RoutID':routeID,
        'numberOfPassengers':'0',
      });

      // Clear the text controllers after adding a route
      fromController.clear();
      toController.clear();
      timeController.clear();
      priceController.clear();
    } else {
      print("One or more fields are empty");
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      drawer: _buildSideDrawer(context),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
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
                print("Updated mapRoutes: $mapRoutes");
              },
              child: Text('Add Route'),
            ),
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
                            Text("${mapRoutes[index]['From']}",style: TextStyle(fontSize: 12),),
                            Text("${mapRoutes[index]['Time']}"),
                            Text("${mapRoutes[index]['To']}"),
                          ],
                        ),
                        leading: Image.asset(
                          "assets/images/car-sharing.png",
                          height: 25,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, "/Cart_screen");
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

  Drawer _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Profile Page', '/Profile_screen'),
          _buildDrawerItem(context, 'Orders History', '/OrderHistory_screen'),
          _buildDrawerItem(context, 'Upcoming Rides', '/UpcommingRides_screen'),
          _buildDrawerItem(context, 'Logout', '/Login_screen'),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.pushNamed(context, route);
      },
    );
  }
}
