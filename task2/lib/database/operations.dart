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
  // updateData(table, data) async {
  //   var connection = await database;
  //   try {
  //     return await connection
  //         ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  //   } catch (err) {
  //     print('There is some error $err');
  //   }
  // }

  // //Delete User
  // deleteDataById(userId) async {
  //   var connection = await database;
  //   try {
  //     await connection?.execute("DELETE FROM userInput where id= $userId");
  //   } catch (err) {
  //     print('There is some error $err');
  //   }
  // }

  insertDataTask1(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readDataTask1(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Update User
  updateDataTask1(table, data) async {
    var connection = await database;
    try {
      return await connection
          ?.update(table, data, where: 'taskId=?', whereArgs: [data['taskId']]);
    } catch (err) {
      print('There is some error $err');
    }
  }

  //Delete User
  deleteDataByIdTask1(taskId) async {
    var connection = await database;
    try {
      await connection?.execute("DELETE FROM taskInput1 where taskId= $taskId");
    } catch (err) {
      print('There is some error $err');
    }
  }

  // <-----------------------   Tabbar2    --------------------------------->
  insertDataTask2(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readDataTask2(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Update User
  updateDataTask2(table, data) async {
    var connection = await database;
    try {
      return await connection
          ?.update(table, data, where: 'taskId=?', whereArgs: [data['taskId']]);
    } catch (err) {
      print('There is some error $err');
    }
  }

  //Delete User
  deleteDataByIdTask2(taskId) async {
    var connection = await database;
    try {
      await connection?.execute("DELETE FROM taskInput2 where taskId= $taskId");
    } catch (err) {
      print('There is some error $err');
    }
  }
  //   <--------------------------   tabbar3 -------------->

  insertDataTask3(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readDataTask3(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Update User
  updateDataTask3(table, data) async {
    var connection = await database;
    try {
      return await connection
          ?.update(table, data, where: 'taskId=?', whereArgs: [data['taskId']]);
    } catch (err) {
      print('There is some error $err');
    }
  }

  //Delete User
  deleteDataByIdTask3(taskId) async {
    var connection = await database;
    try {
      await connection?.execute("DELETE FROM taskInput3 where taskId= $taskId");
    } catch (err) {
      print('There is some error $err');
    }
  }

// ----------------------------            category           ------------------------------->
  //Insert User
  insertDataCategory(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Record
  readDataCategory(table) async {
    var connection = await database;
    return await connection?.query(table);
  }
}
