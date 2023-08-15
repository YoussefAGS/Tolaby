
import 'package:flutter/material.dart';
import 'package:tolaby/modles/student_model.dart';
import 'package:tolaby/utiles/constant.dart';

import '../../../modles/group_model.dart';
import '../../../modles/stage_model.dart';
import '../../../services/Sudent.dart';
import '../student_item.dart';

class ApplyWidget extends StatelessWidget {
  Group group;
  Stage stage;
  ApplyWidget(this.group,this.stage ,{super.key});
  List<Student> students = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColorDark,
      padding: const EdgeInsets.only(left: 4,right: 4),
      child: StreamBuilder<List<Student>>(
        stream: StudentServices.getStudentStream(Groubid:group.id! ), // Replace with the appropriate stream method
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return StudentItem(students[index], group,stage,'Maths');
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          }
        },
      ),
      // child: StreamBuilder<QuerySnapshot<Student>>(
      //   stream: StudentDatabase.readStudentsFormFirebase('${group.teacherId}','${group.stageIdOfGroup}','${group.id}'),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(
      //           child: Text(
      //               'Student View: ${snapshot.error.toString()}'));
      //     } else if (snapshot.hasData) {
      //       students = snapshot.data!.docs.map((e) {
      //         return e.data();
      //       }).toList();
      //     // var sts=students.where((element) => element.subjects.where((e) => e='math'));
      //       group.groupTotalStudents = students.length;
      //       GroupDatabase.updateGroupInFirebase(group);
      //       students.sort((a, b) => a.studentCompleteId!.compareTo(b.studentCompleteId??''));
      //
      //       return ListView.builder(
      //         itemBuilder: (context, index) {
      //           for(int i =0;i<students[index].studentSubjects!.length;i++){
      //             if(students[index].studentSubjects![i]=='Apply'){
      //
      //               return StudentItem(students[index], group,stage,'Apply');
      //             }
      //           }
      //           return const SizedBox(height: 0,);
      //         },
      //         itemCount: students.length,
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
