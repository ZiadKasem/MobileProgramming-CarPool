import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'reusable/reusable_methods.dart';
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
  ReusableMethods rm = ReusableMethods();

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  void initState() {

    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child("routes");
    _setupDataListener();
    print(rm.getFormattedDateTimeWithoutSeconds());
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
                .map((entry) => Map<String, String>.from({
              'From': '${entry.value['From']}',
              'To': '${entry.value['To']}',
              'Time': '${entry.value['Time']}',
              'RoutID':'${entry.value['RoutID']}',
              "Date":'${entry.value['Date']}',
              "price":  '${entry.value['price']}',
              "TripStatus":'${entry.value['TripStatus']}',
            }))
                .toList();
          });
          
          /*if(rm.getCurrentTime().compareTo("21:59")>0){
            print("time after 10PM");

            setState(() {
              mapRoutes = data
                  .where((entry) => '${entry.value['Time']}' =="17:30")
                  .map((entry) => Map<String, String>.from({
                'From': '${entry.value['From']}',
                'To': '${entry.value['To']}',
                'Time': '${entry.value['Time']}',
                'RoutID':'${entry.value['RoutID']}',
                "price":  '${entry.value['price']}',
                "TripStatus":'${entry.value['TripStatus']}',
              }))
                  .toList();
            });

          }
          else if(rm.getFormattedDateTimeWithoutSeconds().compareTo("21:59")<0){
            print("time before 10PM");
            setState(() {
              mapRoutes = data
                  .map((entry) => Map<String, String>.from({
                'From': '${entry.value['From']}',
                'To': '${entry.value['To']}',
                'Time': '${entry.value['Time']}',
                'RoutID':'${entry.value['RoutID']}',
                "price":  '${entry.value['price']}',
                "TripStatus":'${entry.value['TripStatus']}',
              }))
                  .toList();
            });
          }

          else if(rm.getFormattedDateTimeWithoutSeconds().compareTo("21:59")<0){
            print("time before 10PM");
            setState(() {
              mapRoutes = data
                  .map((entry) => Map<String, String>.from({
                'From': '${entry.value['From']}',
                'To': '${entry.value['To']}',
                'Time': '${entry.value['Time']}',
                'RoutID':'${entry.value['RoutID']}',
                "price":  '${entry.value['price']}',
                "TripStatus":'${entry.value['TripStatus']}',
              }))
                  .toList();
            });
          }*/

          

       
       
        }//end of the if condition
      } else {
        print("Snapshot value is null");
      }
    });
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
                            Text("From:${mapRoutes[index]['From']}",style: TextStyle(fontSize: 12),),
                            Text("Time:${mapRoutes[index]['Time']} ${mapRoutes[index]['Date']}"),
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
                              "/Cart_screen",
                              arguments: {"RoutID": "${mapRoutes[index]['RoutID']}"}
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
        if (title != 'Logout')
        {
          Navigator.pop(context); // Close the drawer
          Navigator.pushNamed(context, route);
        }
        else{
          Navigator.pop(context); // Close the drawer
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, route);
        }

      },
    );
  }
}
