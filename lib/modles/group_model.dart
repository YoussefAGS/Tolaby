
import 'package:tolaby/modles/student_model.dart';

import 'message_model.dart';

class Group {
  static const String COLLECTION_NAME = 'Groups';
  String? id;
  String? title;
  String? place;
  String? stageIdOfGroup;
  String? groupStartStudentCode;
  String? teacherId;
  int? groupTotalStudents ;
  int? groupTotalMathsStudents ;
  int? groupTotalApplyStudents ;
  int? groupMaxQuizzes ;
  int? groupMaxHw ;
  int? groupMaxExams  ;
  int? groupMaxApplyQuizzes  ;
  int? groupMaxApplyHw ;
  int? groupMaxApplyExams  ;
  List<Message>? groupsMessages = [];
  int groupRank=0 ;
  List<Student>? groupStudents = [];
  int? v;


  Group(
      {
        required this.groupRank,
        required this.teacherId,
      this.id = ' ',
      required this.title,
      required this.place,
        required this.groupTotalStudents,
      required this.groupStartStudentCode,
        required this.stageIdOfGroup,
        this.groupsMessages,
         this.groupTotalMathsStudents=0,
         this.groupTotalApplyStudents=0,
         this.groupMaxExams=0,
         this.groupMaxHw=0 ,
         this.groupMaxQuizzes=0,
         this.groupMaxApplyExams=0,
         this.groupMaxApplyHw=0,
         this.groupMaxApplyQuizzes=0,
         this.groupStudents,


      });

  Group.fromJson(dynamic json) {
    groupMaxQuizzes=json["Group Max Quizzes"];
    groupMaxExams=json["Group Max Exams"];
    groupMaxHw=json["Group Max HW"];
    groupMaxApplyHw=json["Group Max Apply HW"];
    groupMaxApplyQuizzes=json["Group Max Apply Quizzes"];
    groupMaxApplyExams=json["Group Max Apply Exams"];
    groupRank = json["Group Rank"];
    groupTotalMathsStudents=json['Group Total Maths Students'];
    groupTotalApplyStudents=json['Group Total Apply Students'];
    groupTotalStudents = json['Total Students'];
    id = json['Group Id'];
    title = json['Group Title'];
    place = json['Group Place'];
    teacherId = json['Teacher Id'];
    groupStartStudentCode = json['Group Start Student Code'];
    stageIdOfGroup =json['Stage Id Of Group'];

    if (json['Groups of Messages'] != null) {
      groupsMessages = [];
      json['Groups of Messages'].forEach((v) {
        groupsMessages?.add(Message.fromJson(v));
      });
    }
    if (json['Group of Students'] != null) {
      groupStudents = [];
      json['Group of Students'].forEach((v) {
        groupStudents?.add(Student.fromJson(v));
      });
    }
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["Group Max Quizzes"]=groupMaxQuizzes;
    map["Group Max Exams"]=groupMaxExams;
    map["Group Max HW"]=groupMaxHw;
    map["Group Max Apply Exams"] =groupMaxApplyExams;
    map["Group Max Apply Quizzes"]=groupMaxApplyQuizzes;
    map["Group Max Apply HW"]=groupMaxApplyHw;
    map["Group Rank"]=groupRank;
    map['Group Total Apply Students']=groupTotalApplyStudents;
    map['Group Total Maths Students']=groupTotalMathsStudents;
    map['Total Students'] = groupTotalStudents;
    map['Group Id'] = id;
    map["Group Place"] = place;
    map["Teacher Id"] = teacherId;
    map['Group Title'] = title;
    map['Group Start Student Code'] = groupStartStudentCode;
    map['Stage Id Of Group']=stageIdOfGroup;

    if (groupsMessages != null) {
      map['Groups of Messages'] =
          groupsMessages?.map((v) => v.toJson()).toList();
    }
    if (groupStudents != null) {
      map['Group of Students'] =
          groupStudents?.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;

    return map;
  }
}
