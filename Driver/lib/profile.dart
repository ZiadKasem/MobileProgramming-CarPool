import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'Test_file/GlobalVariableForTesting.dart';
import 'reusable/Text_box_component.dart';
import 'Local Database/My_Database.dart';
import 'reusable/reusable_methods.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late var currentUser;
  late DatabaseReference driversRef;
  late DatabaseReference snapshot;
  String? username;
  String? mobile;

  //late Database localDatabase;
  late MyDatabaseClass myDatabaseClass;

  ReusableMethods rMethods = new ReusableMethods();

  @override
  void initState() {
    super.initState();
    if(TESTMODE == 0){
      currentUser = FirebaseAuth.instance.currentUser!;
    }else{
      print("Assuming we are pointing to FirebaseAuth as Tester");
      currentUser = "TESTER";
    }
    driversRef = FirebaseDatabase.instance.reference();
    if(TESTMODE == 0){
      snapshot = driversRef.child('Drivers/${currentUser.uid}');
    }else{
      snapshot = driversRef.child('Drivers/TEST');
      print("testing");
    }
    if (username == null) username = "loading";
    if (mobile == null) mobile = "loading";
    rMethods.checkConnectivity(context).then((int result)async {
      await initLocalDatabase();
      if (result ==1) {
        print("IF CONDITION OF CONNECTIVITY IS TRUE");
        snapshot.onValue.listen((event) {
          readAttributes();
        });
      } else if (result == 0) {
        // read data of name and phone from database
        print("read data of name and phone from database");

        readLocalData();

      } else {
        print("didn't go to read from local");
      }
    });
  }

  Future<void> initLocalDatabase() async {
    myDatabaseClass = MyDatabaseClass();
  }

  Future<void> readLocalData() async {
    // Read data from the local database
    print("Read data from the local database");
    List<Map<String, dynamic>> result;
    if(TESTMODE == 0){
      result = await myDatabaseClass.getSpacificUser(currentUser.uid);
    }else{
      result = await myDatabaseClass.getSpacificUser("TEST");

    }
    if (result.isNotEmpty) {
      // Data found in the local database
      print("Data found in the local database");
      setState(() {
        username = result[0]['name'].toString();
        mobile = result[0]['phone'].toString();
      });
    } else {
      // No data found in the local database
      if(TESTMODE == 0){
        print('No local data found for user ${currentUser.uid}');
      }else{
        print('No local data found for user TEST');
      }

    }
  }



  Future<void> readAttributes() async {
    DataSnapshot dataSnapshot = await snapshot.get();

    if (dataSnapshot.value != null && dataSnapshot.value is Map<dynamic, dynamic>) {
      Map<dynamic, dynamic> dataMap = dataSnapshot.value as Map<dynamic, dynamic>;

      if (dataMap.containsKey('name') && dataMap.containsKey('phone')) {
        setState(() {
          username = dataMap['name'].toString();
          mobile = dataMap['phone'].toString();
        });

        saveUserDataToLocalDatabase(username!, mobile!);
        myDatabaseClass.printTableContents(); // Trigger printing of table contents
      } else {
        print('Required fields are missing in the dataMap');
      }
    } else {
      print('DataSnapshot value is null or not of type Map<dynamic, dynamic>');
    }
  }

  Future<void> saveUserDataToLocalDatabase(String username, String mobile) async {
    if(TESTMODE==0){
      await myDatabaseClass.InsertOrUpdateUser(currentUser.uid, username, mobile);
    }else{
      await myDatabaseClass.InsertOrUpdateUser(currentUser.uid, username, mobile);

    }

  }

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
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),
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

  Future<void> updateField(String field, String newValue) async {
    try {
      if(TESTMODE ==0){
        await driversRef.child('Drivers/${currentUser.uid}').update({field.toLowerCase(): newValue});
      }else{
        await driversRef.child('Drivers/TEST').update({field.toLowerCase(): newValue});
      }

    } catch (error) {
      print('Error updating $field: $error');
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
          const SizedBox(height: 50),
          Icon(Icons.person, size: 90),
          const SizedBox(height: 20),
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "My Info",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          DefaultTextBox(
            sectionHead: "UserName",
            text: username!,
            onPressed: () => editField("name"),
          ),
          DefaultTextBox(
            sectionHead: "Mobile",
            text: mobile!,
            onPressed: () => editField("phone"),
          ),
        ],
      ),
    );
  }
}