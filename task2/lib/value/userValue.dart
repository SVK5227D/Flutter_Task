// ignore_for_file: camel_case_types

class UserInput {
  int? id, userCount;
  String? fullName, emailid, password, mobileNumber;

  toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['fullName'] = fullName;
    map['emailid'] = emailid;
    map['mobileNumber'] = mobileNumber;
    map['password'] = password;
    return map;
  }
}

class TaskValue1 {
  int? userId;
  int? taskId;
  String? task;
  toMap() {
    var value = <String, dynamic>{};
    value['userId'] = userId;
    value['taskId'] = taskId;
    value['task'] = task;
    return value;
  }
}

class TaskValue2 {
  int? userId;
  int? taskId;
  String? task;
  toMap() {
    var value = <String, dynamic>{};
    value['userId'] = userId;
    value['taskId'] = taskId;
    value['task'] = task;
    return value;
  }
}

class TaskValue3 {
  int? userId;
  int? taskId;
  String? task;
  toMap() {
    var value = <String, dynamic>{};
    value['userId'] = userId;
    value['taskId'] = taskId;
    value['task'] = task;
    return value;
  }
}

class Category {
  int? userId;
  String? categoryOne, categoryTwo, categoryThree;
  toMap() {
    var value = <String, dynamic>{};
    value['userId'] = userId;
    value['categoryOne'] = categoryOne;
    value['categoryTwo'] = categoryTwo;
    value['categoryThree'] = categoryThree;
    return value;
  }
}
