class Teacher {
  Teacher({
      this.id, 
      this.username, 
      this.password, 
      this.phoneNumber, 
      this.address, 
      this.v,});

  Teacher.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    v = json['__v'];
  }
  String? id;
  String? username;
  String? password;
  String? phoneNumber;
  String? address;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['password'] = password;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['__v'] = v;
    return map;
  }

}