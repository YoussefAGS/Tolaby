// import 'package:assistant/database_utils/group_database.dart';
// import 'package:assistant/database_utils/messages_database.dart';
// import 'package:assistant/database_utils/stage_database.dart';
// import 'package:assistant/database_utils/student_database.dart';
// import 'package:assistant/models/group_model.dart';
// import 'package:assistant/models/stage_model.dart';
// import 'package:assistant/ui/teacher/student/degree/update_degree_bottomsheet.dart';
// import 'package:background_sms/background_sms.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../models/degree_model.dart';
// import '../../../../models/message_model.dart';
// import '../../../../models/student_model.dart';
// import '../../../../providers/provider.dart';
// import '../../../../shared/components/alert_ok_dialog_component.dart';
//
// class degreeItem extends StatefulWidget {
//   Degree degree;
//   Student student;
//   Stage stage;
//   Group group;
//   int index;
//   int countQuiz = 0;
//   int countHw = 0;
//   int countExam = 0;
//   int checkdegrees = 0;
//
//   degreeItem(this.degree, this.student, this.index,this.stage,this.group,{super.key});
//
//   @override
//   State<degreeItem> createState() => _degreeItemState();
// }
//
// class _degreeItemState extends State<degreeItem> {
//   int isSelected = 0;
//   String msg = '';
//
//   _getPermission() async => await [Permission.sms,].request();
//
//   Future<bool> _isPermissionGranted() async => await Permission.sms.status.isGranted;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     StudentDatabase.updateStudentInFirebase(widget.student);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.checkdegrees == 0) {
//       widget.checkdegrees = 1;
//       addNumCompleteWorks();
//     }
//     return Container(
//       margin: const EdgeInsets.only(top: 2,bottom: 4),
//       height: MediaQuery.of(context).size.height * 0.1,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: widget.student.studentDegrees?[widget.index].isSend??false == true?Colors.green:Colors.red,
//         border: Border.all(color:widget.student.studentDegrees?[widget.index].isSend??false == true?Colors.green:Colors.red,width: 4 )
//       ),
//       child: Slidable(
//         startActionPane: ActionPane(motion: const ScrollMotion(), children: [
//           SlidableAction(
//             borderRadius: BorderRadius.circular(25),
//             onPressed: (context) {
//               showUpdateDegreeBottomsheet();
//             },
//             backgroundColor: Colors.orange,
//             foregroundColor: Colors.white,
//             icon: Icons.edit,
//           ),
//           const SizedBox(
//             width: 2,
//           ),
//           SlidableAction(
//             borderRadius: BorderRadius.circular(25),
//             onPressed: (context) {
//               showDialog(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: const Text(
//                       'Danger!',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     content: const Text(
//                       'Are You Sure Delete this Degree ?!',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     actions: [
//                       TextButton(
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStatePropertyAll(
//                                   Theme.of(context).colorScheme.primary),
//                               shape: MaterialStatePropertyAll(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(12)))),
//                           onPressed: () {
//                             if (widget.student.studentDegrees![widget.index]
//                                     .typeDegree ==
//                                 'Quiz') {
//                              widget.student.totalCompleteQuiz=widget.student.totalCompleteQuiz!-1;
//                             } else if (widget.student
//                                     .studentDegrees![widget.index].typeDegree ==
//                                 'H.W') {
//                               widget.student.totalCompleteHw =widget.student.totalCompleteHw!-1;
//                             } else if (widget.student
//                                     .studentDegrees![widget.index].typeDegree ==
//                                 'Exam') {
//                               widget.student.totalCompleteExam=widget.student.totalCompleteExam!-1;
//                             }
//                             widget.student.studentDegrees!
//                                 .removeAt(widget.index);
//                             StudentDatabase.updateStudentInFirebase(
//                                 widget.student);
//
//                             for(int i=0;i<widget.stage.totalGroupsOfStage!.length;i++){
//                               for(int j=0;j<widget.stage.totalGroupsOfStage![i].groupStudents!.length;j++){
//                                 if(widget.stage.totalGroupsOfStage![i].groupStudents![j].studentDataBaseID==widget.student.studentDataBaseID){
//                                   widget.stage.totalGroupsOfStage![i].groupStudents![j]=widget.student;
//
//                                   break;
//                                 }
//                               }
//                             }
//                             GroupDatabase.updateGroupInFirebase(widget.group);
//                             StageDatabase.updateStagesInFirebase(widget.stage);
//                             ///--------------------------------------------------------------
//
//                             for(int i=0;i<widget.stage.totalStudentsOfStage!.length;i++){
//                               if(widget.stage.totalStudentsOfStage![i].studentDataBaseID==widget.student.studentDataBaseID){
//                                 widget.stage.totalStudentsOfStage![i]=widget.student;
//                                 break;
//                               }
//                             }
//                             StageDatabase.updateStagesInFirebase(widget.stage);
//                             ///--------------------------------------------------------------
//
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             'Yes',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           )),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       TextButton(
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStatePropertyAll(
//                                   Theme.of(context).colorScheme.primary),
//                               shape: MaterialStatePropertyAll(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(12)))),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Text(
//                             'Cancel',
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           )),
//                     ],
//                   );
//                 },
//               );
//             },
//             backgroundColor: Colors.blue,
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//           ),
//           const SizedBox(
//             width: 2,
//           ),
//         ]),
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(120),
//               color: Colors.white,
//           ),
//           child: Row(
//             children: [
//               const SizedBox(width: 2,),
//               Expanded(
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundColor: widget.student.studentDegrees?[widget.index].isSend??false == true?Colors.green:Colors.red,
//                   child: Text(
//                     '${widget.degree.typeDegree!.substring(0, 1)} ${widget.degree.typeDegree == 'Quiz' ? widget.countQuiz + 1 : widget.degree.typeDegree == 'H.W' ? widget.countHw + 1 : widget.countExam + 1}',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 8,),
//               Expanded(
//                 flex: 3,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${widget.degree.degree} - ${widget.degree.subjectType}  ",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     const SizedBox(height: 4,),
//                     Text(
//                       "Date : ${widget.degree.dateDegree} ",style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 11,
//                     ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Colors.green,
//                   child: IconButton(
//                     onPressed: () async {
//                       widget.student.studentDegrees![widget.index].isSend = true;
//                       StudentDatabase.updateStudentInFirebase(widget.student);
//                       //To remove the keyboard when button is pressed
//                       FocusManager.instance.primaryFocus?.unfocus();
//                       var whatsappUrl =
//                           "whatsapp://send?phone=20${widget.student.studentPhoneNumber}" +
//                               "&text=${Uri.encodeComponent('Dear Parent\n'
//                                   'Kindly be informed about\n'
//                                   'Your student : ${widget.student.studentName}\n'
//                                   'Code : ${widget.student.studentCompleteId}\n'
//                                   'Grade level : ${widget.student.stageNameOfStudent}\n'
//                                   'Mark :  ${widget.student.studentDegrees![widget.index].degree} \ndate ${widget.student.studentDegrees![widget.index].dateDegree}\nType ${widget.student.studentDegrees![widget.index].typeDegree}\n'
//                                   'Best Regards\n'
//                                   'Dr. Mohamed Gamal')}";
//                       try {
//                         launch(whatsappUrl);
//                       } catch (e) {
//                         //To handle error and display error message
//                         print(e);
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16,),
//               Expanded(
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Theme.of(context).colorScheme.primary,
//                   child: IconButton(
//                     onPressed: () async {
//                       msg = 'student : ${widget.student.studentCompleteId} ${widget.student.studentName}\n'
//                           'Grade level : ${widget.student.stageNameOfStudent}\n'
//                           '${widget.student.studentDegrees![widget.index].typeDegree} Mark : ${widget.student.studentDegrees![widget.index].degree} ,date: ${widget.student.studentDegrees![widget.index].dateDegree}\n'
//                           'Dr. Mohamed Gamal';
//
//                       sending_SMS(msg, ['${widget.student.studentPhoneNumber}',]);
//
//                     },
//                     icon: const Icon(
//                       Icons.sms,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 4,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void showUpdateDegreeBottomsheet() {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: UpdateDegreeBottomSheet(widget.student, widget.index,widget.group,widget.stage),
//           );
//         });
//   }
//
//   void addNumCompleteWorks() {
//     for (int i = 0; i < widget.index; i++) {
//       if (widget.student.studentDegrees![i].typeDegree == 'Quiz') {
//         ++widget.countQuiz;
//       } else if (widget.student.studentDegrees![i].typeDegree == 'H.W') {
//         ++widget.countHw;
//       } else if (widget.student.studentDegrees![i].typeDegree == 'Exam') {
//         ++widget.countExam;
//       }
//     }
//     setState(() {});
//   }
//
//   Future<void> checkWhatsappMessage() async {
//     Stream<QuerySnapshot<Message>> temp =
//         await MessagesDatabase.readMessagesFormFirebase(
//             '${widget.student.teacherId}',
//             '${widget.student.stageIdOfStudent}',
//             '${widget.student.groupIdOfStudent}');
//     if (await temp.isEmpty) {
//     } else {
//       isSelected = 0;
//       setState(() {});
//     }
//   }
//
//   Future<void> sending_SMS(String msg, List<String> list_receipents)  async {
//     if(widget.student.studentParentPhoneNumber!.length==11){
//       if (await _isPermissionGranted()) {
//         var result = await BackgroundSms.sendMessage(
//           phoneNumber: "${widget.student.studentParentPhoneNumber}", message: msg,);
//         if (result == SmsStatus.sent) {
//           widget.student.studentDegrees![widget.index].isSend = true;
//           StudentDatabase.updateStudentInFirebase(widget.student);
//         } else {
//           widget.student.studentDegrees![widget.index].isSend = false;
//           StudentDatabase.updateStudentInFirebase(widget.student);
//         }
//       }
//       else{
//         _getPermission();
//
//       }
//     }
//     else{
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return  AlertDialogOkComponent(
//             alertTitle: 'Note!',
//             alertContent: 'wrong parent number ',
//           );
//         },
//       );
//     }
//
//
//   }
// }
