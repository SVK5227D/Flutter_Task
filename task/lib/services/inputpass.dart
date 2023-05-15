import '../Database/bdcrud.dart';
import 'package:task/map_value.dart';

// ignore_for_file: non_constant_identifier_names

class UserService {
  late OperationValue _repository;
  UserService() {
    _repository = OperationValue();
  }
  //Save User
  SaveUser(UserInput user) async {
    print('Save user function called in services');
    print(user.toMap());
    return await _repository.insertData('userInput', user.toMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('userInput');
  }

  //Edit User
  UpdateUser(UserInput user) async {
    return await _repository.updateData('userInput', user.toMap());
  }

  deleteUser(userId) async {
    return await _repository.deleteDataById(userId);
  }
}
