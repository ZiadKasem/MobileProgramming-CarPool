import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'reusable/Text_box_component.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User currentUser;
  late DatabaseReference usersRef;
  late DatabaseReference snapshot;
  String? username; // Declare username
  String? mobile;   // Declare mobile

  @override
  void initState() {
    super.initState();

    // Move your initialization here
    currentUser = FirebaseAuth.instance.currentUser!;
    usersRef = FirebaseDatabase.instance.ref();
    snapshot = usersRef.child('users/${currentUser.uid}');
    readAttributes();

    // give username and mobile value until they are caught
    if (username == null) username = "loading";
    if (mobile == null) mobile = "loading";

    // Listen for changes in the data
    snapshot.onValue.listen((event) {
      readAttributes();
    });
  }

  Future<void> readAttributes() async {
    DataSnapshot dataSnapshot = await snapshot.get();

    // Check if dataSnapshot.value is not null and is of type Map<String, dynamic>
    if (dataSnapshot.value != null && dataSnapshot.value is Map<dynamic, dynamic>) {
      // Explicitly cast dataSnapshot.value to Map<String, dynamic>
      Map<dynamic, dynamic> dataMap = dataSnapshot.value as Map<dynamic, dynamic>;

      // Check if the required fields are present in the dataMap
      if (dataMap.containsKey('name') && dataMap.containsKey('phone')) {
        setState(() {
          username = dataMap['name'].toString();
          mobile = dataMap['phone'].toString();
        });
      } else {
        //  required fields are missing
        print('Required fields are missing in the dataMap');
      }
    } else {
      //  dataSnapshot.value is null or not of the expected type
      print('DataSnapshot value is null or not of type Map<dynamic, dynamic>');
    }
  }

  // Method to Edit Field
  Future<void> editField(String field) async {
    print("Edit field function called");
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),

          //saving button
          TextButton(
            child: Text("Save", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              Navigator.of(context).pop(newValue);
              await updateField(field, newValue);
            },
          ),
        ],
      ),
    );
  }

// Method to Update Field in Firebase
  Future<void> updateField(String field, String newValue) async {
    try {
      // Update the field in Firebase under the user's UID
      await usersRef.child('users/${currentUser.uid}').update({field.toLowerCase(): newValue});
    } catch (error) {
      print('Error updating $field: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Picture
          const SizedBox(height: 50,),
          Icon(Icons.person, size: 90,),
          // Email
          const SizedBox(height: 20,),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          // Details
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "My Info",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          // Username
          DefaultTextBox(
            sectionHead: "UserName",
            text: username!,
            onPressed: () => editField("name"),
          ),
          // Mobile
          DefaultTextBox(
            sectionHead: "Mobile",
            text: mobile!,
            onPressed: () => editField("phone"),
          ),
          // AccountType
        ],
      ),
    );
  }
}
