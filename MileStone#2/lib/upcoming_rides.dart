import 'package:flutter/material.dart';
class UpcommingRides extends StatefulWidget {

  const UpcommingRides({super.key});

  @override
  State<UpcommingRides> createState() => _UpcommingRidesState();
}

class _UpcommingRidesState extends State<UpcommingRides> {
  List UpcommingData = [

    {

      "From":"From:Abasya square",
      "To"  :"To:Gate 3 Faculty Of Engineering",
      "Time":"7:30 AM"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UpcommingRides page"),
      ),
      body:Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: UpcommingData.length,
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
                      Text("${UpcommingData[index]['From']}",style: TextStyle(fontSize: 12),),
                      Text("${UpcommingData[index]['Time']}"),
                      Text("${UpcommingData[index]['To']}"),
                    ],
                  ),
                  leading:Image.asset("assets/images/car-sharing.png",
                    height: 25,
                  ),


                  onTap: () {
                    Navigator.pushNamed(context, "/OrderTracking_screen");
                  },
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
