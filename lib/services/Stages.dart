import 'dart:convert';

import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/modles/teacher_modle/Teacher_model.dart';
import 'package:tolaby/utiles/constant.dart';
import '../utiles/api.dart';
import 'package:http/http.dart' as http;


class StagesServices {
  static Future<List<Stage>?> getStags() async {
    List<dynamic> response = await Api().get(url:'https://tolapyserver.onrender.com/teachers/${teacherr.teacher?.id}/stages');
    int n = response.length;
    List<Stage> products = [];
    for (int i = 0; i < n; i++) {
      products.add(Stage.fromJson(response[i]));
    }
    return products;
  }
  static Stream<List<Stage>> getStagesStream() async* {
    while (true) {
      List<dynamic> response =
      await Api().get(url: 'https://tolapyserver.onrender.com/teachers/${teacherr.teacher?.id}/stages');
      int n = response.length;
      List<Stage> stages = [];
      for (int i = 0; i < n; i++) {
        stages.add(Stage.fromJson(response[i]));
      }
      yield stages;

      await Future.delayed(Duration(seconds: 5)); // Delay before fetching again
    }
  }
  ///---------------------------------------------------------------
  static Future<void> addStage({required Stage stage}) async {
    await Api().post(url: "https://tolapyserver.onrender.com/stages", body: {
      "title": "${stage.title}",
      "teacherId": "${stage.teacherId}",
    });
  }
  static Stream<void> addStageStream({required Stage stage}) async* {
    await Api().post(url: "https://tolapyserver.onrender.com/stages", body: {
      "title": "${stage.title}",
      "teacherId": "${stage.teacherId}",
    });
  }
  ///---------------------------------------------------------------
  static Stream<Stage> updateStageStream({
    required String title,
    String subject = 'gg',
    required String id,
  }) async* {
    Map<String, dynamic> response = await Api().put(url: 'https://tolapyserver.onrender.com/stages/$id', body: {
      "title": "$title",
    });
    yield Stage.fromJson(response);
  }
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
  static Stream<void> deleteStageStream({required String id}) async* {
    print("ffffffffffffffffffffffffffffffff${id}");
    await Api().deleteData(url: "https://tolapyserver.onrender.com/stages/${id}");
  }
}
