import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tolaby/screens/group/add_group.dart';
import 'package:tolaby/screens/group/group_widget.dart';
import 'package:tolaby/screens/group/update_group.dart';
import 'package:tolaby/screens/home/home_categories/home_categories_view.dart';
import 'package:tolaby/screens/home/teacher_home_view/teacher_home_view.dart';
import 'package:tolaby/screens/login/bloc_login/login_bloc.dart';
import 'package:tolaby/screens/login/login_view.dart';
import 'package:tolaby/screens/stage/view/UpdatstageView.dart';
import 'package:tolaby/screens/stage/view/stage_view.dart';
import 'package:tolaby/utiles/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc()..add(InitialLoginEvent()),
        child: MaterialApp(
          color: Colors.transparent,
          debugShowCheckedModeBanner: false,
          initialRoute: Login.routName,
          routes: {
            Login.routName: (_) => Login(),
            HomeCategoriesWidget.routeName: (_) => HomeCategoriesWidget(),
            TeacherHomeWidget.routeName: (_) => TeacherHomeWidget(),
            StageView.routName:(_)=>StageView(),
            UpdateStage.routeName:(_)=>UpdateStage(),
            GroupWidget.routeName:(_)=>GroupWidget(),
            AddGroupWidget.routeName:(_)=>AddGroupWidget(),
            UpdateGroup.routeName:(_)=>UpdateGroup()
          },
        ));
  }
}
