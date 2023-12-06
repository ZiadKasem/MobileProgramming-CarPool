import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_database/firebase_database.dart';

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
    String Path = join(destinationPath, "USERPROJECTDB");
    Database mydatabase = await openDatabase(
      Path,
      version: Version,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS users (
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

  Future<void> syncDataFromFirebase() async {
    DatabaseReference reference = FirebaseDatabase.instance.reference();

    // Use child event listener to get updates
    reference.child('users').onChildAdded.listen((event) {
      var value = event.snapshot.value;

      // Ensure that the value is not null and is a Map
      if (value != null && value is Map<dynamic, dynamic>) {
        Map<String, dynamic> userData = Map<String, dynamic>.from(value);
        userData['id'] = event.snapshot.key;

        // Insert or update the SQLite database with Firebase data
        batchInsertOrUpdateUsers([userData]);
      }
    });
  }

  Future<void> batchInsertOrUpdateUsers(List<Map<String, dynamic>> userList) async {
    Database? temp = await mydbcheck();

    var batch = temp!.batch();

    for (var user in userList) {
      batch.rawInsert('''
        INSERT OR REPLACE INTO users (id, name, email, phone)
        VALUES (?, ?, ?, ?)
      ''', [user['id'], user['name'], user['email'], user['phone']]);
    }

    await batch.commit();

    // Print table contents after updating
    await printTableContents();
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database? temp = await mydbcheck();
    var response = await temp!.rawQuery('SELECT * FROM users');
    return response;
  }

  Future<void> printTableContents() async {
    // Print the contents of the users table
    List<Map<String, dynamic>> users = await getUsers();

    users.forEach((user) {
      print('from local Database User ID: ${user['id']}, Name: ${user['name']}, Email: ${user['email']}, Phone: ${user['phone']}');
    });
  }

  Future<void> checking() async {
    String destinationPath = await getDatabasesPath();
    String Path = join(destinationPath, "USERPROJECTDB");
    await databaseExists(Path) ? print("Lucky man") : print("maybe next time");
  }

  Future<void> reseting() async {
    String destinationPath = await getDatabasesPath();
    String Path = join(destinationPath, "USERPROJECTDB");
    await deleteDatabase(Path);
  }

  Future<int> writing(String table, Map<String, dynamic> values) async {
    Database? temp = await mydbcheck();
    return temp!.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> reading(String table, String column) async {
    Database? temp = await mydbcheck();
    return temp!.query(table, where: '$column = ?', whereArgs: [column]);
  }

  Future<int> updating(String table, Map<String, dynamic> values, String column) async {
    Database? temp = await mydbcheck();
    return temp!.update(table, values, where: '$column = ?', whereArgs: [column]);
  }

  Future<int> deleting(String table, String column) async {
    Database? temp = await mydbcheck();
    return temp!.delete(table, where: '$column = ?', whereArgs: [column]);
  }
}
