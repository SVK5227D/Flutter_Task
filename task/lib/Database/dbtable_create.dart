import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore_for_file: non_constant_identifier_names

class DatabaseConnection {
  Future<Database> setDatabase() async {
    print("Path connection has called");
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'task2');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future _createDatabase(Database database, int version) async {
    print('Table create query execute next');
    await database.execute(
      "CREATE TABLE userInput ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "firstName TEXT,"
      "lastName TEXT,"
      "emailid TEXT,"
      "mobileNumber TEXT,"
      "percentage FLOAT"
      ")",
    );
    // print('query running');
    // String query = "userInput";
    // var result = await database.query(query);
    // print(result);
  }
}
