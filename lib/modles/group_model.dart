
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
    groupMaxQuizzes=json["groupMaxQuizzes"];
    groupMaxExams=json["groupMaxExams"];
    groupMaxHw=json["groupMaxHw"];
    groupMaxApplyHw=json["groupMaxApplyHw"];
    groupMaxApplyQuizzes=json["groupMaxApplyQuizzes"];
    groupMaxApplyExams=json["groupMaxApplyExams"];
    groupRank = json["groupRank"];
    groupTotalMathsStudents=json['groupTotalMathsStudents'];
    groupTotalApplyStudents=json['groupTotalApplyStudents'];
    groupTotalStudents = json['groupTotalStudents'];
    id = json['id'];
    title = json['title'];
    place = json['place'];
    teacherId = json['teacherId'];
    groupStartStudentCode = json['groupStartStudentCode'];
    stageIdOfGroup =json['stageIdOfGroup'];

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
    map["groupMaxQuizzes"]=groupMaxQuizzes;
    map["groupMaxExams"]=groupMaxExams;
    map["groupMaxHw"]=groupMaxHw;
    map["groupMaxApplyExams"] =groupMaxApplyExams;
    map["groupMaxApplyQuizzes"]=groupMaxApplyQuizzes;
    map["groupMaxApplyHw"]=groupMaxApplyHw;
    map["groupRank"]=groupRank;
    map['groupTotalApplyStudents']=groupTotalApplyStudents;
    map['groupTotalMathsStudents']=groupTotalMathsStudents;
    map['groupTotalStudents'] = groupTotalStudents;
    map['_id'] = id;
    map["place"] = place;
    map["teacherId"] = teacherId;
    map['title'] = title;
    map['groupStartStudentCode'] = groupStartStudentCode;
    map['stageIdOfGroup']=stageIdOfGroup;

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
