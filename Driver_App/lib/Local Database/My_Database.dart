import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Test_file/GlobalVariableForTesting.dart';

class MyDatabaseClass {
  Database? mydb;

  Future<Database?> mydbcheck() async {
    if (mydb == null) {
      mydb = await initiatingDatabase();
      return mydb;
    } else
      return mydb;
  }

  int Version = 1;
  Future<Database?> initiatingDatabase() async {
    String destinationPath = await getDatabasesPath();
    String Path = join(destinationPath, "DRIVERPROJECTDB");
    Database mydatabase = await openDatabase(
      Path,
      version: Version,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS drivers (
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            phone TEXT
          )
        ''');
      },
    );
    return mydatabase;
  }


  Future<List<Map<String, dynamic>>> getUsers() async {
    Database? temp = await mydbcheck();
    var response = await temp!.rawQuery('SELECT * FROM drivers');
    return response;
  }

  Future<void> printTableContents() async {
    // Print the contents of the drivers table
    List<Map<String, dynamic>> drivers = await getUsers();

    drivers.forEach((user) {
      print('from local Database User ID: ${user['id']}, Name: ${user['name']}, Email: ${user['email']}, Phone: ${user['phone']}');
    });
  }

  Future<List<Map<String, dynamic>>> getSpacificUser(String uid) async {
    Database? temp = await mydbcheck();
    var response = await temp!.rawQuery('''
      SELECT * FROM drivers WHERE id = ?
    ''', [uid]);
    return response;
  }

  Future<void> InsertOrUpdateUser(var uid,String username,String mobile) async {
    Database? temp = await mydbcheck();
    if(TESTMODE==0){
      print("not storing tester values in local database");
      var response = await temp!.rawInsert('''
      INSERT OR REPLACE INTO drivers (id, name, phone)
      VALUES (?, ?, ?)
    ''', [uid, username, mobile]);
      // Print table contents after updating
      await printTableContents();
    }
    else{
      print("storing tester values in local database");
      var response = await temp!.rawInsert('''
      INSERT OR REPLACE INTO drivers (id, name, phone)
      VALUES (?, ?, ?)
    ''', ["TEST", username, mobile]);
      // Print table contents after updating
      await printTableContents();
    }
  }
}
