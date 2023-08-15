import 'attendance_model.dart';
import 'degree_model.dart';

class Student {
  static const String studentCollectionName = 'Students';
  static const String archiveStudentCollectionName = 'Archives';
  String? studentId;
  String? studentCompleteId;
  String? startStudentCode;
  String? teacherId;
  String? studentDataBaseID;
  String? studentName;
  String? studentEmail;
  String? studentImageUrl = '';
  String? studentPhoneNumber = '';
  String? studentParentPhoneNumber = '';
  String? studentAddress = '';
  int? totalCompleteQuiz ;
  int? totalCompleteHw ;
  int? totalCompleteExam ;
  int? totalCompleteApplyQuiz ;
  int? totalCompleteApplyHw ;
  int? totalCompleteApplyExam ;
  int? totalAttendanceLessons ;
  String? groupIdOfStudent;
  String? groupNameOfStudent;
  String? studentStartDate;
  String? stageIdOfStudent;
  String? stageNameOfStudent;
  String? groupStartCodeOfStudent;
  List<Degree>?studentDegrees = [];
  List<Attendance>? studentAttendances = [];
  List<dynamic>? studentSubjects = [];
  bool? isSend = true;
  int? v;

  Student({
    required this.studentCompleteId,
    required this.startStudentCode,
    required this.studentId,
    required this.studentName,
    required this.studentEmail,
    required this.studentPhoneNumber,
    required this.studentParentPhoneNumber,
    required this.studentAddress,
    required this.studentImageUrl,
    this.totalCompleteQuiz=0,
    this.totalCompleteHw=0,
    this.totalCompleteExam=0,
    this.totalCompleteApplyQuiz=0,
    this.totalCompleteApplyHw=0,
    this.totalCompleteApplyExam=0,
    this.totalAttendanceLessons,
    required this.groupIdOfStudent,
    required this.groupNameOfStudent,
    required this.stageIdOfStudent,
    required this.studentStartDate,
    required this.stageNameOfStudent,
    required this.groupStartCodeOfStudent,
    required this.teacherId,
    this.studentAttendances,
    this.studentDegrees,
    required this.studentSubjects,
    this.isSend,

  });

  Student.fromJson(dynamic json) {
    studentCompleteId = json["studentCompleteId"];
    startStudentCode = json['startStudentCode'];
    studentId = json['studentId'];
    teacherId = json['teacherId'];
    studentDataBaseID= json['_id'];
    studentName = json['studentName'];
    studentImageUrl = json['studentImageUrl'];
    studentEmail = json['studentEmail'];
    studentPhoneNumber = json['studentPhoneNumber'];
    studentParentPhoneNumber= json['studentParentPhoneNumber'];
    studentAddress = json['studentAddress'];
    totalCompleteQuiz = json['totalCompleteQuiz'];
    totalCompleteHw = json['totalCompleteHw'];
    totalCompleteExam = json['totalCompleteExam'];
    totalCompleteApplyQuiz = json['totalCompleteApplyQuiz'];
    totalCompleteApplyHw = json['totalCompleteApplyHw'];
    totalCompleteApplyExam = json['totalCompleteApplyExam'];
    totalAttendanceLessons = json['totalAttendanceLessons'];
    studentStartDate = json['studentStartDate'];
    groupIdOfStudent=json['groupIdOfStudent'];
    groupNameOfStudent=json['groupNameOfStudent'];
    stageIdOfStudent=json['stageIdOfStudent'];
    stageNameOfStudent=json['stageNameOfStudent'];
    studentSubjects=json['studentSubjects'];
    isSend = json['isSend'];
    if (json['Student Degrees'] != null) {
      studentDegrees  = [];
      json['Student Degrees'].forEach((v) {
        studentDegrees?.add(Degree.fromJson(v));
      });
    }
    if (json['Student Attendances'] != null) {
      studentAttendances  = [];
      json['Student Attendances'].forEach((v) {
        studentAttendances?.add(Attendance.fromJson(v));
      });
    }
    v = json['__v'];

  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["studentCompleteId"]=studentCompleteId;
    map["studentId"] = studentId;
    map['startStudentCode']=startStudentCode;
    map["_id"] = studentDataBaseID;
    map["studentName"] = studentName;
    map["studentImageUrl"] = studentImageUrl;
    map["studentEmail"] = studentEmail;
    map["studentPhoneNumber"] = studentPhoneNumber;
    map["studentParentPhoneNumber"] = studentParentPhoneNumber;
    map["studentAddress"] = studentAddress;
    map["totalCompleteQuiz"] = totalCompleteQuiz;
    map["totalCompleteHw"] = totalCompleteHw;
    map["totalCompleteExam"] = totalCompleteExam;
    map["totalCompleteApplyQuiz"] = totalCompleteApplyQuiz;
    map["totalCompleteApplyHw"] = totalCompleteApplyHw;
    map["totalCompleteApplyExam"] = totalCompleteApplyExam;
    map["totalAttendanceLessons"] = totalAttendanceLessons;
    map["studentStartDate"] = studentStartDate;
    map["groupIdOfStudent"] = groupIdOfStudent;
    map["groupNameOfStudent"] = groupNameOfStudent;
    map["stageIdOfStudent"] = stageIdOfStudent;
    map["stageNameOfStudent"] = stageNameOfStudent;
    map['teacherId']=teacherId;
    map['studentSubjects']= studentSubjects;
    map['isSend'] = isSend;
    if (studentDegrees != null) {
      map['Student Degrees'] = studentDegrees?.map((v) => v.toJson()).toList();
    }
    if (studentAttendances != null) {
      map['Student Attendances'] = studentAttendances?.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;

    return map;
  }
}
