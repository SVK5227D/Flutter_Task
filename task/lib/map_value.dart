class UserInput {
  int? id;
  String? firstName, lastName, emailid, mobileNumber;
  double? percentage;

  toMap() {
    print('tomap active');
    var map = <String, dynamic>{};
    map['id'] = id;
    map["firstName"] = firstName;
    map["lastName"] = lastName;
    map["emailid"] = emailid;
    map["mobileNumber"] = mobileNumber;
    map["percentage"] = percentage;
    return map;
  }
}
