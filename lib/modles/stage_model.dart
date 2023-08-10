

import 'package:tolaby/modles/group_model.dart';
import 'package:tolaby/modles/student_model.dart';

class Stage{
  static const String COLLECTION_NAME = 'Stages';
  String? id;
  String? title;
  // String? subject;
  String? teacherId;
  int totalStudentsOfStageNumber =0;
  int totalStudentsOfApplyStageNumber =0;
  int totalGroupsOfStageNumber =0;
  int totalAttendanceGroups =0;
  int stageRank=0 ;
  int groupRank=0 ;
  int groupAttendanceRank =0;
  int stageStudentsRank =10;
  List<Student>? totalStudentsOfStage = [];
  List<Group>? totalGroupsOfStage=[];
  int? v;

  Stage({
       required this.stageRank ,
    required this.groupRank ,
    required this.teacherId,
    required this.stageStudentsRank,
    this.id=" ",
    required this.title,
    // required this.subject,
    required this.totalStudentsOfStage,
    required this.totalAttendanceGroups,
      required this.totalStudentsOfStageNumber,
    required this.totalStudentsOfApplyStageNumber,
  required this.totalGroupsOfStage,
    required this.groupAttendanceRank,
    required this.totalGroupsOfStageNumber,
  });

  Stage.fromJson(Map<String, dynamic> json){
    teacherId= json['teacherId'];
    id= json['_id'];
    title= json['title'];
    // subject=json['subject'];
    totalStudentsOfStageNumber=json['totalStudentsOfStageNumber'];
    totalStudentsOfApplyStageNumber=json['totalStudentsOfApplyStageNumber'];
    totalGroupsOfStageNumber = json['totalGroupsOfStageNumber'];
    totalAttendanceGroups = json['totalAttendanceGroups'];
    stageRank=json['stageRank'];
    groupRank=json['groupRank'];
    stageStudentsRank=json['stageStudentsRank'];
    groupAttendanceRank = json['groupAttendanceRank'];
    if (json['Students'] != null) {
      totalStudentsOfStage = [];
      json['Students'].forEach((v) {
        totalStudentsOfStage?.add(Student.fromJson(v));
      });
    }
    if (json['Groups'] != null) {
      totalGroupsOfStage = [];
      json['Groups'].forEach((v) {
        totalGroupsOfStage?.add(Group.fromJson(v));
      });
    }
    v = json['__v'];

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["totalGroupsOfStageNumber"]=totalGroupsOfStageNumber;
    map["totalStudentsOfStageNumber"]=totalStudentsOfStageNumber;
    map["totalStudentsOfApplyStageNumber"]=totalStudentsOfApplyStageNumber;
    map["stageRank"]=stageRank;
    map["groupRank"]=groupRank;
    map["teacherId"]= teacherId;
    map['stageStudentsRank']=  stageStudentsRank;
    map['groupAttendanceRank']=groupAttendanceRank;
    map["_id"]= id;
    map["title"]= title;
    // map["subject"]= subject;
    map['totalAttendanceGroups']=totalAttendanceGroups;
    if (totalStudentsOfStage != null) {
      map['Students'] = totalStudentsOfStage?.map((v) => v.toJson()).toList();
    }
    if (totalGroupsOfStage != null) {
      map['Groups'] = totalGroupsOfStage?.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;
   return map;
  }


}