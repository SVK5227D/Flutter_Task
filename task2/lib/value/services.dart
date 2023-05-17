import '../database/operations.dart';
import 'package:task2/value/userValue.dart';

// ignore_for_file: non_constant_identifier_names

class UserService {
  late OperationValue _repository;
  UserService() {
    _repository = OperationValue();
  }
  //Save User
  saveUser(UserInput user) async {
    return await _repository.insertData('userInput', user.toMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('userInput');
  }

  // //Edit User
  // updateUser(UserInput user) async {
  //   return await _repository.updateData('userInput', user.toMap());
  // }

  // deleteUser(userId) async {
  //   return await _repository.deleteDataById(userId);
  // }

  saveUserTask1(TaskValue1 user) async {
    return await _repository.insertDataTask1('taskInput1', user.toMap());
  }

  //Read All Users
  readAllUsersTask1() async {
    return await _repository.readDataTask1('taskInput1');
  }

  //Edit User
  updateUserTask1(TaskValue1 user) async {
    return await _repository.updateDataTask1('taskInput1', user.toMap());
  }

  deleteUserTask1(taskInput1) async {
    return await _repository.deleteDataByIdTask1(taskInput1);
  }

  // <-----------------------   Tabbar2    --------------------------------->
  saveUserTask2(TaskValue2 user) async {
    return await _repository.insertDataTask2('taskInput2', user.toMap());
  }

  //Read All Users
  readAllUsersTask2() async {
    return await _repository.readDataTask2('taskInput2');
  }

  //Edit User
  updateUserTask2(TaskValue2 user) async {
    return await _repository.updateDataTask2('taskInput2', user.toMap());
  }

  deleteUserTask2(taskInput1) async {
    return await _repository.deleteDataByIdTask2(taskInput1);
  }

  //   <--------------------------   tabbar3 -------------->
  saveUserTask3(TaskValue3 user) async {
    return await _repository.insertDataTask3('taskInput3', user.toMap());
  }

  //Read All Users
  readAllUsersTask3() async {
    return await _repository.readDataTask3('taskInput3');
  }

  //Edit User
  updateUserTask3(TaskValue3 user) async {
    return await _repository.updateDataTask3('taskInput3', user.toMap());
  }

  deleteUserTask3(taskInput1) async {
    return await _repository.deleteDataByIdTask3(taskInput1);
  }

  // ----------------------------            category           ------------------------------->
  // //Save User
  // saveUserCategory(Category user) async {
  //   return await _repository.insertDataCategory('category', user.toMap());
  // }

  // //Read All category
  // readUsersCategory() async {
  //   return await _repository.readDataCategory('category');
  // }
}
