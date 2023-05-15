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

  //Edit User
  updateUser(UserInput user) async {
    return await _repository.updateData('userInput', user.toMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById(userId);
  }
}
