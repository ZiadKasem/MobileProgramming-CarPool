import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPaymentMethod = 'Cash';
  bool _isCashSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/avatarman.png'),
            ),

            SizedBox(height: 20,),

            Text(
              "Rider name: Ahmed Mahmoud",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "PickUp point: Gate 3",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Destination point: Abbaseya square.",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Trip Status: OnTime",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Price: 10EGP",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20 ,
              ),
            ),

            SizedBox(height: 20,),

            Text(
              "Choose payment Method",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),

            SizedBox(height: 10,),

            // RadioListTile option
            RadioListTile<bool>(
              title: Text('Cash'),
              value: true,
              groupValue: _isCashSelected,
              onChanged: (bool? value) {
                setState(() {
                  _isCashSelected = value ?? false;
                  _selectedPaymentMethod = _isCashSelected ? 'Cash' : 'Other';
                });
              },
            ),

            RadioListTile<bool>(
              title: Text('Visa'),
              value: false,
              groupValue: _isCashSelected,
              onChanged: (bool? value) {
                setState(() {
                  _isCashSelected = value ?? true;
                  _selectedPaymentMethod = _isCashSelected ? 'Cash' : 'Visa';
                });
              },
            ),

            // DropdownButton option
            SizedBox(height: 10,),



            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
