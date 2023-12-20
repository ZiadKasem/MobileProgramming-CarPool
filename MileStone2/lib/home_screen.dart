import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project/Test_file/GlobalVariableForTesting.dart';
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
  late String currentDate;
  late String currentTime;
  late String tommorowDate;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  bool TWENTY_ONE_THERTY_FLAG = false;
  bool TWENTY_TWO_THERTY_FLAG = false;
  bool TWELVE_THERTY_FLAG = false;
  bool THIRTEEN_THERTY_FLAG = false;
  bool ONE_THERTY_FLAG = false;
  bool DEFAULT_FLAG = true;




  void initState() {

    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child("routes");
    _setupDataListener();
    currentDate = rm.getFormattedDateTimeWithoutSeconds().split(" ")[0];
    currentTime = rm.getFormattedDateTimeWithoutSeconds().split(" ")[1];
    tommorowDate=rm.getTomorrowDate();

    printTimeFlags();


  }

  void _setupDataListener() {
    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        print("Retrieved Data: ${event.snapshot.value}");

        // The retrieved data is a map, convert entries to a list
        var data = (event.snapshot.value as Map<dynamic, dynamic>).entries;

        if (data != null) {
          setState(() {


            if((currentTime.compareTo("12:59") <0 && DEFAULT_FLAG) || TWELVE_THERTY_FLAG || ONE_THERTY_FLAG){
              print("current time after Midnight and before 1PM");

              mapRoutes = data
                  .where((entry) =>


                  (entry.value['Time'] == "17:30" &&  ("${entry.value['Date']}".compareTo(currentDate)>=0))||
                  (entry.value['Time'] == "7:30" &&  ("${entry.value['Date']}".compareTo(tommorowDate)>=0))



              )
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


            }
            else if((currentTime.compareTo("12:59") >0  && currentTime.compareTo("21:59") <0 && DEFAULT_FLAG) || THIRTEEN_THERTY_FLAG || TWENTY_ONE_THERTY_FLAG ){
              print("current time after 1PM and before 10 PM");
              mapRoutes = data
                  .where((entry) =>


              (("${entry.value['Date']}".compareTo(currentDate)>0))



              )
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

            }
            else if((currentTime.compareTo("21:59") >0 && DEFAULT_FLAG) || TWENTY_TWO_THERTY_FLAG ){
              print("current time after  10 PM");

              mapRoutes = data
                  .where((entry) =>

              (entry.value['Time'] == "17:30" &&  ("${entry.value['Date']}".compareTo(tommorowDate)>=0))||
              (entry.value['Time'] == "7:30" &&  ("${entry.value['Date']}".compareTo(tommorowDate)>0))



              )
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



            }
            else{
              print("you may missed a case");

            }
          });
        }//end of the if condition
      } else {
        print("Snapshot value is null");
      }
    });
  }


  printTimeFlags(){
    print("TWENTY_ONE_THERTY_FLAG:${TWENTY_ONE_THERTY_FLAG}");
    print("TWENTY_TWO_THERTY_FLAG:${TWENTY_TWO_THERTY_FLAG}");
    print("TWELVE_THERTY_FLAG:${TWELVE_THERTY_FLAG}");
    print("THIRTEEN_THERTY_FLAG:${THIRTEEN_THERTY_FLAG}");
    print("ONE_THERTY_FLAG:${ONE_THERTY_FLAG}");
    print("DEFAULT:${DEFAULT_FLAG}");
    _setupDataListener();
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
            Text("time to bypass for testing"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: (){
                    TWENTY_ONE_THERTY_FLAG = true;
                    TWENTY_TWO_THERTY_FLAG = false;
                    TWELVE_THERTY_FLAG = false;
                    THIRTEEN_THERTY_FLAG = false;
                    ONE_THERTY_FLAG = false;
                    DEFAULT_FLAG = false;
                    printTimeFlags();
                  },
                  child:Text("21:30",style: TextStyle(fontSize: 15),),
                ),
                ElevatedButton(
                  onPressed: (){
                    TWENTY_ONE_THERTY_FLAG = false;
                    TWENTY_TWO_THERTY_FLAG = true;
                    TWELVE_THERTY_FLAG = false;
                    THIRTEEN_THERTY_FLAG = false;
                    ONE_THERTY_FLAG = false;
                    DEFAULT_FLAG = false;
                    printTimeFlags();
                  },
                  child:Text("22:30",style: TextStyle(fontSize: 15),),
                ),
                ElevatedButton(
                  onPressed: (){
                    TWENTY_ONE_THERTY_FLAG = false;
                    TWENTY_TWO_THERTY_FLAG = false;
                    TWELVE_THERTY_FLAG = true;
                    THIRTEEN_THERTY_FLAG = false;
                    ONE_THERTY_FLAG = false;
                    DEFAULT_FLAG = false;
                    printTimeFlags();
                  },
                  child:Text("12:30",style: TextStyle(fontSize: 15),),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: (){
                    TWENTY_ONE_THERTY_FLAG = false;
                    TWENTY_TWO_THERTY_FLAG = false;
                    TWELVE_THERTY_FLAG = false;
                    THIRTEEN_THERTY_FLAG = true;
                    ONE_THERTY_FLAG = false;
                    DEFAULT_FLAG = false;
                    printTimeFlags();
                  },
                  child:Text("13:30",style: TextStyle(fontSize: 15),),
                ),
                ElevatedButton(
                  onPressed: (){
                    TWENTY_ONE_THERTY_FLAG = false;
                    TWENTY_TWO_THERTY_FLAG = false;
                    TWELVE_THERTY_FLAG = false;
                    THIRTEEN_THERTY_FLAG = false;
                    ONE_THERTY_FLAG = true;
                    DEFAULT_FLAG = false;
                    printTimeFlags();
                  },
                  child:Text("1:30",style: TextStyle(fontSize: 15),),
                ),
                ElevatedButton(
                  onPressed: (){
                    TWENTY_ONE_THERTY_FLAG = false;
                    TWENTY_TWO_THERTY_FLAG = false;
                    TWELVE_THERTY_FLAG = false;
                    THIRTEEN_THERTY_FLAG = false;
                    ONE_THERTY_FLAG = false;
                    DEFAULT_FLAG = true;
                    printTimeFlags();
                    },
                  child:Text("default",style: TextStyle(fontSize: 15),),

                ),
              ],
            ),
            TWENTY_ONE_THERTY_FLAG?Text("Time is 21:30"):
            TWENTY_TWO_THERTY_FLAG?Text("Time is 22:30"):
            TWELVE_THERTY_FLAG?Text("Time is 12:30"):
            THIRTEEN_THERTY_FLAG?Text("Time is 13:30"):
            ONE_THERTY_FLAG?Text("Time is 1:30"):
            Text("default Time"),

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
