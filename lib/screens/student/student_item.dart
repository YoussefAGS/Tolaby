
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tolaby/modles/group_model.dart';
import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/modles/student_model.dart';
import 'package:tolaby/screens/student/student_profile/student_details.dart';
import 'package:tolaby/screens/student/update_student.dart';
import 'package:tolaby/screens/student/widgets/AlertDialogOkComponent.dart';
import 'package:tolaby/screens/student/widgets/AlirtDaialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../stage/widgets/ScreenLockComponent.dart';
import 'degree/add_degree_bottomsheet.dart';

class StudentItem extends StatefulWidget {
  Student student;
  Group group;
  Stage stage;
  String dropdownValue;

  StudentItem(this.student, this.group, this.stage, this.dropdownValue,
      {super.key});

  @override
  State<StudentItem> createState() => _StudentItemState();
}

class _StudentItemState extends State<StudentItem> {
  String fsQuiz = 'Quiz';


  _getPermission() async => await [Permission.sms,].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Slidable(
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(25),
            onPressed: (context) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return  ScreenLockComponent((){
                    for (int i = 0; i <
                        widget.student.studentSubjects!.length; i++) {
                      if (widget.student.studentSubjects![i] == 'Maths') {
                        widget.group.groupTotalStudents =
                            widget.group.groupTotalStudents! - 1;
                        widget.group.groupTotalMathsStudents =
                            widget.group.groupTotalMathsStudents! - 1;
                        widget.stage.totalStudentsOfStageNumber--;
                      }
                      else
                      if (widget.student.studentSubjects![i] == 'Apply') {
                        widget.group.groupTotalStudents =
                            widget.group.groupTotalStudents! - 1;
                        widget.group.groupTotalApplyStudents =
                            widget.group.groupTotalApplyStudents! - 1;
                        widget.stage.totalStudentsOfApplyStageNumber--;
                      }
                    }
                    for (int i = 0; i <
                        widget.group.groupStudents!.length; i++) {
                      if (widget.group.groupStudents![i].studentId ==
                          widget.student.studentId) {
                        widget.group.groupStudents!.removeAt(i);
                        break;
                      }
                    }
                    for (int i = 0; i <
                        widget.stage.totalStudentsOfStage!.length; i++) {
                      if (widget.stage.totalStudentsOfStage![i].studentId ==
                          widget.student.studentId) {
                        widget.stage.totalStudentsOfStage!.removeAt(i);
                        break;
                      }
                    }
                    // StudentDatabase.deleteStudent(widget.student);
                    // ArchiveDatabase.addStudentToArchiveInFireBase(widget.student);
                    ///-----------------------------------------------------


                    for(int i=0;i<widget.stage.totalGroupsOfStage!.length;i++){
                      for(int j =0 ; j<widget.stage.totalGroupsOfStage![i].groupStudents!.length;j++){
                        if(widget.stage.totalGroupsOfStage![i].groupStudents![j].studentDataBaseID==widget.student.studentDataBaseID){
                          widget.stage.totalGroupsOfStage![i].groupStudents!.removeAt(j);
                          break;
                        }
                      }
                    }
                    // GroupDatabase.updateGroupInFirebase(widget.group);
                    ///-----------------------------------------------------
                    for(int i=0;i<widget.stage.totalStudentsOfStage!.length;i++){
                      if(widget.stage.totalStudentsOfStage![i].studentDataBaseID==widget.student.studentDataBaseID){
                        widget.stage.totalStudentsOfStage!.removeAt(i);
                        break;
                      }
                    }
                    // StageDatabase.updateStagesInFirebase(widget.stage);
                    ///-----------------------------------------------------

                    Navigator.pop(context);
                  });
                },
              );
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            icon: Icons.archive,
          ),
          const SizedBox(
            width: 4,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(25),
            onPressed: (context) {
              Navigator.pushNamed(context, UpdateStudent.routeName,
                  arguments: AllStudentAndGroup(
                      widget.student, widget.group, widget.stage,
                      widget.dropdownValue));
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          const SizedBox(
            width: 4,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(25),
            onPressed: (context) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialogComponent(
                      alertTitle: 'Danger !',
                      alertContent:
                      'Are You Sure Delete ${widget.student.studentName} ?!',
                      onPrssedNo: () {
                        Navigator.pop(context);
                      },
                      onPrssedYes: () {
                        // StudentDatabase.deleteStudent(widget.student);
                        for (int i = 0; i <
                            widget.student.studentSubjects!.length; i++) {
                          if (widget.student.studentSubjects![i] == 'Maths') {
                            widget.group.groupTotalStudents =
                                widget.group.groupTotalStudents! - 1;
                            widget.group.groupTotalMathsStudents =
                                widget.group.groupTotalMathsStudents! - 1;
                            --widget.stage.totalStudentsOfStageNumber;
                          }
                          else
                          if (widget.student.studentSubjects![i] == 'Apply') {
                            widget.group.groupTotalStudents =
                                widget.group.groupTotalStudents! - 1;
                            widget.group.groupTotalApplyStudents =
                                widget.group.groupTotalApplyStudents! - 1;
                            --widget.stage.totalStudentsOfApplyStageNumber;
                          }
                        }
                        for (int i = 0; i <
                            widget.group.groupStudents!.length; i++) {
                          if (widget.group.groupStudents![i]
                              .studentDataBaseID ==
                              widget.student.studentDataBaseID) {
                            widget.group.groupStudents!.removeAt(i);
                            break;
                          }
                        }
                        // GroupDatabase.updateGroupInFirebase(widget.group);
                        ///-----------------------------------------------------


                        for (int i = 0; i <
                            widget.stage.totalGroupsOfStage!.length; i++) {
                          if (widget.stage.totalStudentsOfStage![i]
                              .studentDataBaseID ==
                              widget.student.studentDataBaseID) {
                            widget.stage.totalStudentsOfStage!.removeAt(i);
                            break;
                          }
                        }
                        // StageDatabase.updateStagesInFirebase(widget.stage);
                        Navigator.pop(context);
                      });
                },
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
          const SizedBox(
            width: 8,
          ),
        ]),
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, StudentDetails.routeName,
            //     arguments: AllStudentAndGroup(
            //         widget.student, widget.group, widget.stage,
            //         widget.dropdownValue));
          },
          child: Container(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            margin: const EdgeInsets.only(bottom: 8, right: 2, left: 2),
            height: 232,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white, width: 2),
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Expanded(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: widget.dropdownValue == 'Maths' ? widget
                      //         .student.totalCompleteQuiz! ==
                      //         widget.group.groupMaxQuizzes ? Colors
                      //         .lightGreenAccent : widget.student
                      //         .totalCompleteQuiz! ==
                      //         widget.group.groupMaxQuizzes! - 1
                      //         ? Colors.orange
                      //         : Colors.red
                      //         : widget.student.totalCompleteApplyQuiz! ==
                      //         widget.group.groupMaxApplyQuizzes ? Colors
                      //         .lightGreenAccent : widget.student
                      //         .totalCompleteApplyQuiz! ==
                      //         widget.group.groupMaxApplyQuizzes! - 1 ? Colors
                      //         .orange : Colors.red,
                      //     borderRadius: BorderRadius.circular(22)
                      // ),
                      child: const Center(child: Text('Q', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),)),
                    ),
                  ),
                  const SizedBox(width: 4,),
                  Expanded(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: widget.dropdownValue == 'Maths' ? widget
                      //         .student.totalCompleteHw! ==
                      //         widget.group.groupMaxHw
                      //         ? Colors.lightGreenAccent
                      //         : widget.student.totalCompleteHw! ==
                      //         widget.group.groupMaxHw! - 1
                      //         ? Colors.orange
                      //         : Colors.red
                      //         : widget.student.totalCompleteApplyHw! ==
                      //         widget.group.groupMaxApplyHw ? Colors
                      //         .lightGreenAccent : widget.student
                      //         .totalCompleteApplyHw! ==
                      //         widget.group.groupMaxApplyHw! - 1
                      //         ? Colors.orange
                      //         : Colors.red,
                      //     borderRadius: BorderRadius.circular(22)
                      // ),
                      child: const Center(child: Text('H', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),)),
                    ),
                  ),
                  const SizedBox(width: 4,),
                  Expanded(
                    child: Container(
                      // decoration: BoxDecoration(
                      //     color: widget.dropdownValue == 'Maths' ? widget
                      //         .student.totalCompleteExam! ==
                      //         widget.group.groupMaxExams ? Colors
                      //         .lightGreenAccent : widget.student
                      //         .totalCompleteExam! ==
                      //         widget.group.groupMaxExams! - 1
                      //         ? Colors.orange
                      //         : Colors.red
                      //         : widget.student.totalCompleteApplyExam! ==
                      //         widget.group.groupMaxApplyExams ? Colors
                      //         .lightGreenAccent : widget.student
                      //         .totalCompleteApplyExam! ==
                      //         widget.group.groupMaxApplyExams! - 1 ? Colors
                      //         .orange : Colors.red,
                      //     borderRadius: BorderRadius.circular(22)
                      // ),
                      child: const Center(child: Text('E', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),)),
                    ),
                  ),
                ],),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Center(
                          child: Text(
                            "${widget.group.groupStartStudentCode}${widget
                                .student.studentId}  ${widget.student
                                .studentName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8,),
                  margin: const EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red.shade800,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Quiz : ${widget.dropdownValue == 'Maths' ? widget
                              .student.totalCompleteQuiz : widget.student
                              .totalCompleteApplyQuiz }",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "H.w : ${widget.dropdownValue == 'Maths' ? widget
                              .student.totalCompleteHw : widget.student
                              .totalCompleteApplyHw}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Exam : ${widget.dropdownValue == 'Maths' ? widget
                              .student.totalCompleteExam : widget.student
                              .totalCompleteApplyExam}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),


                //todo : Student
                Row(
                  children: [

                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "${widget.student.studentPhoneNumber}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          call("${widget.student.studentPhoneNumber}");
                        },
                        icon: const Icon(
                          Icons.call,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green,
                      child: IconButton(
                        onPressed: () {
                          whatsAppMessageForStudent("${widget.student
                              .studentPhoneNumber}", "provider.message");
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),

                //todo : Parent
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.people_alt_rounded,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        "${widget.student.studentParentPhoneNumber}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          call("${widget.student.studentParentPhoneNumber}");
                        },
                        icon: const Icon(
                          Icons.call,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.green,
                      child: IconButton(
                        onPressed: () async {
                          whatsAppMessageForStudent("${widget.student
                              .studentParentPhoneNumber}", "provider.message");
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          //sendLastMessageOfStudentForParent();
                          sendLastSMS();
                        },
                        style: ButtonStyle(
                            backgroundColor: widget.student.studentDegrees
                                ?.length == 0
                                ? const MaterialStatePropertyAll(
                              Colors.white,
                            )
                                : widget.student.studentDegrees?.last.isSend ==
                                true ? const MaterialStatePropertyAll(
                                Colors.green) : const MaterialStatePropertyAll(
                                Colors.white),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            visualDensity: VisualDensity.comfortable),
                        child: Text(
                          widget.student.studentDegrees?.length == 0
                              ? 'Send Last Mark'
                              : widget.student.studentDegrees?.last.isSend ==
                              true ? 'Sent' : 'Send Last Mark',
                          style: TextStyle(
                            color: widget.student.studentDegrees?.length == 0
                                ? Colors.black
                                : widget.student.studentDegrees?.last.isSend ==
                                true ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showDegreeBottomSheet();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          visualDensity: VisualDensity.comfortable,
                        ),
                        child: const Text(
                          'Add New Mark',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showDegreeBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            // child: AddDegreeBottomSheet(
            //     widget.student, widget.group, widget.stage, fsQuiz,
            //     widget.dropdownValue),
          );
        });
  }


  void call(String number) {
    launch("tel://$number");
  }

  void whatsAppMessageForStudent(String number, String message) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var whatsappUrl =
        "whatsapp://send?phone=20$number" +
            "&text=${Uri.encodeComponent(message)}";
    try {
      launch(whatsappUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendLastSMS() async {
    if (widget.student.studentDegrees?.length == 0) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(
                  Icons.crisis_alert_outlined,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Note!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Marks Not Found',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
    }

    else {
      //Telephony telephony = Telephony.instance;
      String msg = 'student : ${widget.student.studentCompleteId} ${widget.student.studentName}\n'
          'Grade level : ${widget.student.stageNameOfStudent}\n'
          '${widget.student.studentDegrees![widget.student.studentDegrees!.length - 1].typeDegree} Mark :  ${widget.student.studentDegrees![widget.student.studentDegrees!.length - 1]
          .degree} , date ${widget.student.studentDegrees![widget.student
          .studentDegrees!.length - 1].dateDegree}\n'
          'Dr. Mohamed Gamal';
      if (widget.student.studentParentPhoneNumber!.length==11) {
        if (await _isPermissionGranted()) {
          var result = await BackgroundSms.sendMessage(
            phoneNumber: "${widget.student.studentParentPhoneNumber}",
            message: msg,);
          if (result == SmsStatus.sent) {
            widget.student.studentDegrees![widget.student.studentDegrees!
                .length - 1].isSend = true;
            // StudentDatabase.updateStudentInFirebase(widget.student);
          } else {
            widget.student.studentDegrees![widget.student.studentDegrees!
                .length - 1].isSend = false;
            // StudentDatabase.updateStudentInFirebase(widget.student);
          }
        }
        else {
          _getPermission();
        }
      }
      else{
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return  AlertDialogOkComponent(
              alertTitle: 'Note!',
              alertContent: 'wrong parent number ',
            );
          },
        );
      }


      //
      // telephony.sendSms(
      //   to: '${widget.student.studentParentPhoneNumber}',
      //   message: msg,statusListener: (status) {
      //   if(status == SendStatus.SENT){
      //     widget.student.studentDegrees![widget.student.studentDegrees!.length-1].isSend = true;
      //     StudentDatabase.updateStudentInFirebase(widget.student);
      //   }
      //   else{
      //     widget.student.studentDegrees![widget.student.studentDegrees!.length-1].isSend = false;
      //     StudentDatabase.updateStudentInFirebase(widget.student);
      //   }
      //   return status;
      // },
      // );
    }
  }

  void sendLastMessageOfStudentForParent() async {
    if (widget.student.studentDegrees!.isNotEmpty) {
      widget.student.studentDegrees!.last.isSend = true;
      // StudentDatabase.updateStudentInFirebase
      (
          widget.student);
    }
    FocusManager.instance.primaryFocus?.unfocus();
    if (widget.student.studentDegrees![widget.student.studentDegrees!.length -
        1].degree != '') {

    }
    if (!widget.student.studentDegrees!.isEmpty) {
      var whatsappUrl =
          "whatsapp://send?phone=20${widget.student.studentParentPhoneNumber}" +
              "&text=${Uri.encodeComponent(
                  'Student : ${widget.student.studentId} ${widget.student
                      .studentName}'
                      'Degree : ${widget.student.studentDegrees![widget.student
                      .studentDegrees!.length - 1].degree}\n'
                      'Date : ${widget.student.studentDegrees![widget.student
                      .studentDegrees!.length - 1].dateDegree}'
                      'Type : ${widget.student.studentDegrees![widget.student
                      .studentDegrees!.length - 1].typeDegree}'
                      'Subject : ${widget.student.studentDegrees![widget.student
                      .studentDegrees!.length - 1].subjectType}')}";
      try {
        launch(whatsappUrl);
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(
                  Icons.crisis_alert_outlined,
                  color: Colors.orange,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Note!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            content: const Text(
              'There is any Marks for this student.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK')),
            ],
          );
        },
      );
    }
  }
}



class AllStudentAndGroup {
  Student st;
  Group gr;
  Stage sta;
  String dropdownValue;

  AllStudentAndGroup(this.st, this.gr, this.sta, this.dropdownValue);

}
