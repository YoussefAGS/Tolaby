import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tolaby/modles/teacher_modle/Teacher_model.dart';
import 'package:tolaby/utiles/constant.dart';
import '../../../modles/teacher_modle/Teacher.dart';
import '../../../services/login_user.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is InitialLoginEvent) {
        print('ghhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        emit(StateLoginLoading());
        if (sharedPreferences?.getString('loged') == 'yes') {
          print('ggoooooooooooooooooooooooooooooooooooooooooo');
          final userJson = sharedPreferences?.getString('Teacher');
          if (userJson != null) {
            teacherr = TeacherModel.fromJson(jsonDecode(userJson));
            emit(StateLoginSuccess());
            print('ggggggggggggggggggggggggggggggggggggggggggggggggggggggg');
          }
          else {
            emit(StateLogoutSuccess());
          }
        }
        else {
          emit(StateLogoutSuccess());
        }
      }
      else if (event is SuccessLoginEvent) {
        emit(StateLoginLoading());
        print("pppppppppppppppppppppppppppppppp");
        if (await loginWithFirbaseAuth(event.userName, event.password)) {
          emit(StateLoginSuccess());
        }
        else {
          emit(StateLogoutSuccess());
        }
      }
    });
  }

  Future<bool> loginWithFirbaseAuth(
      String emailAddress, String password) async {
    TeacherModel? Teacher = await LoginUser.Login(email: emailAddress, password: password);
    if (Teacher != null) {
      final userJson =
      jsonEncode(Teacher.toJson()); // Serialize the User model to JSON
      sharedPreferences?.setString('Teacher', userJson);
      sharedPreferences?.setString("loged", 'yes');
      teacherr = Teacher;
      return true;
    } else
      return false;
  }
}
