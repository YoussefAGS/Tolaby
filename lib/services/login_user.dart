import 'package:provider/provider.dart';
import 'package:tolaby/modles/teacher_modle/Teacher_model.dart';
import '../utiles/api.dart';

class LoginUser {
  static Future<TeacherModel?> Login({required String email, required String password,}) async {
    Map<String, dynamic> data = await Api().post(
      url: 'https://tolapyserver.onrender.com/login',
      body: {
        "username": email,
        "password": password
      },
    );
    if(data.isNotEmpty){
      TeacherModel user=TeacherModel.fromJson(data);
      return user;
    }
    else return null;
    return null;
  }
}
