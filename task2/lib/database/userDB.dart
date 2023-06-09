import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// ignore_for_file: avoid_print

// ignore_for_file: non_constant_identifier_names

class DatabaseConnection {
  Future<Database> setDatabase() async {
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
      "id INTEGER PRIMARY KEY AUTOINCREMENT,"
      "fullName TEXT,"
      "emailid TEXT,"
      "mobileNumber TEXT,"
      "password TEXT"
      ")",
    );
    print('table2');
    await database.execute(
      "CREATE TABLE taskInput1 ("
      "taskId INTEGER PRIMARY KEY AUTOINCREMENT,"
      "userId INTEGER,"
      "task TEXT"
      ")",
    );
    await database.execute(
      "CREATE TABLE taskInput2 ("
      "taskId INTEGER PRIMARY KEY AUTOINCREMENT,"
      "userId INTEGER,"
      "task TEXT"
      ")",
    );
    await database.execute(
      "CREATE TABLE taskInput3 ("
      "taskId INTEGER PRIMARY KEY AUTOINCREMENT,"
      "userId INTEGER,"
      "task TEXT"
      ")",
    );
    // await database.execute(
    //   "CREATE TABLE category ("
    //   "userId INTEGER,"
    //   "categoryOne Text,"
    //   "categoryTwo Text,"
    //   "categoryThree Text"
    //   ")",
    // );
  }
}
