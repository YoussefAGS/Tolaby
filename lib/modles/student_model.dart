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
    studentCompleteId = json["Student Complete Id"];
    startStudentCode = json['Start Student Code'];
    studentId = json['Student Id'];
    teacherId = json['Teacher Id'];
    studentDataBaseID= json['Student DataBase ID'];
    studentName = json['Student First Name'];
    studentImageUrl = json['Student image Url'];
    studentEmail = json['Student Email'];
    studentPhoneNumber = json['Student PhoneNumber'];
    studentParentPhoneNumber= json['Student Parent  PhoneNumber'];
    studentAddress = json['Student Address'];
    totalCompleteQuiz = json['Total Complete Quiz'];
    totalCompleteHw = json['Total Complete Hw'];
    totalCompleteExam = json['Total Complete Exam'];
    totalCompleteApplyQuiz = json['Total Complete Apply Quiz'];
    totalCompleteApplyHw = json['Total Complete Apply Hw'];
    totalCompleteApplyExam = json['Total Complete Apply Exam'];
    totalAttendanceLessons = json['Total Attendance Lessons'];
    studentStartDate = json['Student Start Date'];
    groupIdOfStudent=json['Group Id Of Student'];
    groupNameOfStudent=json['Group Name Of Student'];
    stageIdOfStudent=json['Stage Id Of Student'];
    stageNameOfStudent=json['Stage Name Of Student'];
    studentSubjects=json['Student Subjects'];
    isSend = json['Is Send'];
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
    map["Student Complete Id"]=studentCompleteId;
    map["Student Id"] = studentId;
    map['Start Student Code']=startStudentCode;
    map["Student DataBase ID"] = studentDataBaseID;
    map["Student First Name"] = studentName;
    map["Student Image Url"] = studentImageUrl;
    map["Student Email"] = studentEmail;
    map["Student PhoneNumber"] = studentPhoneNumber;
    map["Student Parent  PhoneNumber"] = studentParentPhoneNumber;
    map["Student Address"] = studentAddress;
    map["Total Complete Quiz"] = totalCompleteQuiz;
    map["Total Complete Hw"] = totalCompleteHw;
    map["Total Complete Exam"] = totalCompleteExam;
    map["Total Complete Apply Quiz"] = totalCompleteApplyQuiz;
    map["Total Complete Apply Hw"] = totalCompleteApplyHw;
    map["Total Complete Apply Exam"] = totalCompleteApplyExam;
    map["Total Attendance Lessons"] = totalAttendanceLessons;
    map["Student Start Date"] = studentStartDate;
    map["Group Id Of Student"] = groupIdOfStudent;
    map["Group Name Of Student"] = groupNameOfStudent;
    map["Stage Id Of Student"] = stageIdOfStudent;
    map["Stage Name Of Student"] = stageNameOfStudent;
    map['Teacher Id']=teacherId;
    map['Student Subjects']= studentSubjects;
    map['Is Send'] = isSend;
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
