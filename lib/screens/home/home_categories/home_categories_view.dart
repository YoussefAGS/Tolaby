
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolaby/screens/home/widgets/catigory.dart';
import 'package:tolaby/screens/stage/stagebloc/stages_bloc.dart';

import '../../../base.dart';
import '../../stage/view/stage_view.dart';
import 'home_category_navigator.dart';
import 'home_category_view_model.dart';



class HomeCategoriesWidget extends StatefulWidget {
  static const String routeName = 'Home Categories Widget';

  const HomeCategoriesWidget({super.key});

  @override
  State<HomeCategoriesWidget> createState() => _HomeCategoriesWidgetState();
}

class _HomeCategoriesWidgetState extends BaseView<HomeCategoriesWidget, HomeCategoryViewModel>
    implements HomeCategoryNavigator  {
  @override
  HomeCategoryViewModel initViewModel() {
    return HomeCategoryViewModel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(20, 26, 46, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text('Assistant',style: TextStyle(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dr / MOHAMED GAMAL',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ],),
               SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              Row(children: [
                Expanded(
                  child: CategoryComponent(
                    categoryOnTap:(){
                      Navigator.pushNamed(context, StageView.routName);
                    } ,
                    categoryTitle: 'Stages',
                    categoryBackgroundColor: Theme.of(context).colorScheme.primary,
                    categoryIcon: const Icon(Icons.school,color: Colors.white),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                Expanded(
                  child: CategoryComponent(
                    categoryOnTap:(){
                    },
                    categoryTitle: 'Attendance',
                    categoryBackgroundColor: Theme.of(context).colorScheme.primary,
                    categoryIcon: const Icon(Icons.add_chart,color: Colors.white),

                  ),
                ),
              ],),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),

              Row(
                children: [
                  Expanded(
                    child: CategoryComponent(
                      categoryOnTap:(){
                        viewModel.navigator?.goToSMS();
                      } ,
                      categoryTitle: 'Send SMS',
                      categoryBackgroundColor: Theme.of(context).colorScheme.primary,
                      categoryIcon: const Icon(Icons.sms,color: Colors.white),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),

                  Expanded(
                    child: CategoryComponent(
                      categoryOnTap:(){
                        // Navigator.pushNamed(context, FollowStudent.routeName);
                      } ,
                      categoryTitle: 'Follow',
                      categoryBackgroundColor: Theme.of(context).colorScheme.primary,
                      categoryIcon: const Icon(Icons.follow_the_signs_rounded,color: Colors.white),

                    ),
                  ),
                ],),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Row(
                children: [
                  Expanded(
                    child: CategoryComponent(
                      categoryOnTap:(){
                        // Navigator.pushNamed(context,  RestView.routeName);
                      } ,
                      categoryTitle: 'Reset',
                      categoryBackgroundColor: Theme.of(context).colorScheme.primary,
                      categoryIcon: const Icon(Icons.restart_alt,color: Colors.white),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                  Expanded(
                    child: CategoryComponent(
                      categoryOnTap:(){
                        // Navigator.pushNamed(context, SettingTab.routeName);
                      } ,
                      categoryTitle: 'Settings',
                      categoryBackgroundColor: Theme.of(context).colorScheme.primary,
                      categoryIcon: const Icon(Icons.settings,color: Colors.white,),

                    ),
                  ),
                ],),


            ],
          ),
        ),
      ),
    );
  }


  @override
  void goToStages() {
    Navigator.pushNamed(context, StageView.routName);
  }

  @override
  void goToAttendance() {
    // Navigator.pushNamed(context, StageAttendanceView.routeName);
  }

  @override
  void goToSMS() {
    // Navigator.pushNamed(context, SendSMS.routeName);
  }


}
