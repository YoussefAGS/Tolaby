import 'Teacher.dart';

class TeacherModel {
  TeacherModel({
       this.teacher,
       this.token,});

  TeacherModel.fromJson(dynamic json) {
    teacher = json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null;
    token = json['token'];
  }
  Teacher? teacher;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (teacher != null) {
      map['teacher'] = teacher?.toJson();
    }
    map['token'] = token;
    return map;
  }

}