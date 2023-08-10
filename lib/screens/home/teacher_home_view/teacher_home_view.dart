import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:tolaby/utiles/constant.dart';
import '../home_categories/home_categories_view.dart';

class TeacherHomeWidget extends StatefulWidget {
  static String routeName = 'Home Widget';
  const TeacherHomeWidget({super.key});
  @override
  State<TeacherHomeWidget> createState() => _TeacherHomeWidgetState();
}

class _TeacherHomeWidgetState extends State<TeacherHomeWidget> {
  int currentIndex = 0;
  List<Widget> tabs = [const HomeCategoriesWidget(),];
  bool isAuth = false;
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return isAuth? Scaffold(
      body:  tabs[currentIndex],
    ) : teacherr.teacher !=null ?
    Scaffold(
        body: ScreenLock(
                title: const Text('Pleas Enter Passcode'),
                correctString:teacherr.teacher?.phoneNumber?.isNotEmpty == true?"${teacherr.teacher?.phoneNumber}":'233',
                onUnlocked: () {
                  isAuth = true;
                  setState(() {
                  });
                },
              ),
        )
    :Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator(color: Colors.blue,),),
          SizedBox(height: 4,),
          Center(child: Text('Loading...',style: TextStyle(
            fontSize: 18,
            color: Colors.blue,
            fontWeight: FontWeight.bold
          ),)),
        ],
      ),
    );
  }

}