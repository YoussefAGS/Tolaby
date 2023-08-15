
import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/modles/student_model.dart';
import 'package:tolaby/utiles/constant.dart';
import '../utiles/api.dart';
import 'package:http/http.dart' as http;


class StudentServices {
  static Future<List<Student>?> getStudent(String id) async {
    List<dynamic> response = await Api().get(url:'https://tolapyserver.onrender.com/groups/$id/students');
    int n = response.length;
    List<Student> products = [];
    for (int i = 0; i < n; i++) {
      products.add(Student.fromJson(response[i]));
    }
    return products;
  }
  static Stream<List<Student>> getStudentStream({required String Groubid}) async* {
    while (true) {
      List<dynamic> response =
      await Api().get(url: 'https://tolapyserver.onrender.com/groups/$Groubid/students');
      int n = response.length;
      List<Student> stages = [];
      for (int i = 0; i < n; i++) {
        stages.add(Student.fromJson(response[i]));
      }
      yield stages;

      await Future.delayed(Duration(seconds: 1)); // Delay before fetching again
    }
  }
  ///---------------------------------------------------------------
  static Future<void> addStudent({required Student student}) async {
    await Api().post(url: "https://tolapyserver.onrender.com/student", body: {
      "studentName":"${student.studentName}",
      "groupIdOfStudent":"${student.groupIdOfStudent}",
      "teacherId":"${teacherr.teacher!.id}",
      // "studentCompleteId" : "${student.studentCompleteId}",
      // "startStudentCode" : "${student.startStudentCode}",
      // "studentId" : "${student.studentId}",
      // "studentPhoneNumber": "${student.studentPhoneNumber}",
      // "studentParentPhoneNumber": "${student.studentParentPhoneNumber}",
      // "studentAddress":"ddddd",
      // "totalCompleteQuiz" : 0,
      // "totalCompleteHw" : 0,
      // "totalCompleteExam" :0,
      // "totalCompleteApplyQuiz" : 0,
      // "totalCompleteApplyHw" : 0,
      // "totalCompleteApplyExam" : 0,
      // "totalAttendanceLessons" : 0,
      // "studentStartDate" : 0,
      // "groupNameOfStudent":"${student.groupNameOfStudent}",
      // "stageNameOfStudent":"${student.stageNameOfStudent}",
      // "studentSubjects":"${student.studentSubjects}",
      // "isSend" : true
    });
  }
  // static Stream<void> addStageStream({required Stage stage}) async* {
  //   await Api().post(url: "https://tolapyserver.onrender.com/stages", body: {
  //     "title": "${stage.title}",
  //     "teacherId": "${stage.teacherId}",
  //   });
  // }
  ///---------------------------------------------------------------
  // static Stream<Stage> updateStageStream({
  //   required String title,
  //   String subject = 'gg',
  //   required String id,
  // }) async* {
  //   Map<String, dynamic> response = await Api().put(url: 'https://tolapyserver.onrender.com/stages/$id', body: {
  //     "title": "$title",
  //   });
  //   yield Stage.fromJson(response);
  // }
  static Future<Stage> updateStags({required String title, String subject='gg',required String id,}) async {
    Map<String, dynamic> response =
    await Api().put(url:'https://tolapyserver.onrender.com/stages/$id', body: {
      "title": "$title",
    });
    return Stage.fromJson(response);
  }
  ///---------------------------------------------------------------
  static Future<void> deleatStage({required String id})async{
    await Api().deleteData(url:"https://tolapyserver.onrender.com/stages/$id");
  }
  // static Stream<void> deleteStageStream({required String id}) async* {
  //   print("ffffffffffffffffffffffffffffffff${id}");
  //   await Api().deleteData(url: "https://tolapyserver.onrender.com/stages/${id}");
  // }
}
