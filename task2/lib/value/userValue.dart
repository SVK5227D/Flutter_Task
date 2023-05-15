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
    map['userCount'] = userCount;
    return map;
  }
}

class taskValue {
  int? id;
  String? task;
  toMap() {
    var value = <String, dynamic>{};
    value['id'] = id;
    value['task'] = task;
  }
}
