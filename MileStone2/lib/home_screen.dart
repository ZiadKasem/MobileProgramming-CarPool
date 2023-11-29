import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  final List<Map<String, String>> mapRoutes = [
    {"From": "From:Abasya square", "To": "To:Gate 3 Faculty Of Engineering", "Time": "7:30 AM"},
    {"From": "From:NasrCiry", "To": "To:Gate 4 Faculty Of Engineering", "Time": "7:30 AM"},
    {"From": "From:Gate 3 Faculty Of Engineering", "To": "To:Abasya square", "Time": "5:30 PM"},
    {"From": "From:Gate 4 Faculty Of Engineering", "To": "To:Abasya square", "Time": "5:30 PM"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      drawer: _buildSideDrawer(context),
      body: Container(


        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: mapRoutes.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the space as needed
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
                  leading:Image.asset("assets/images/car-sharing.png",
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
