import 'package:sqflite/sqflite.dart';
import 'package:task2/database/userDB.dart';
// ignore_for_file: avoid_print
// ignore_for_file: prefer_interpolation_to_compose_strings

class OperationValue {
  late DatabaseConnection _databaseConnection;
  OperationValue() {
    _databaseConnection = DatabaseConnection();
  }
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  //Insert User
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Update User
  updateData(table, data) async {
    var connection = await database;
    try {
      return await connection
          ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
    } catch (err) {
      print('There is some error $err');
    }
  }

  //Delete User
  deleteDataById(userId) async {
    var connection = await database;
    try {
      await connection?.execute("DELETE FROM userInput where id= $userId");
    } catch (err) {
      print('There is some error $err');
    }
  }
}
