import 'package:flutter/material.dart';
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List HistoryData = [
    {

      "From":"From:Abasya square",
      "To"  :" To:Gate 3 Faculty Of Engineering",
      "Time":"Time:7:30 AM"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History Page"),

      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: HistoryData.length,
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
                      Text("${HistoryData[index]['From']}",style: TextStyle(fontSize: 12),),
                      Text("${HistoryData[index]['Time']}"),
                      Text("${HistoryData[index]['To']}"),
                    ],
                  ),
                  leading:Image.asset("assets/images/car-sharing.png",
                    height: 25,
                  ),


                  onTap: () {

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
