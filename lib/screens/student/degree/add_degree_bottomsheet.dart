//
// import 'dart:async';
//
// import 'package:assistant/database_utils/stage_database.dart';
// import 'package:assistant/database_utils/student_database.dart';
// import 'package:assistant/shared/components/alert_ok_dialog_component.dart';
// import 'package:assistant/shared/components/connection_networ_component.dart';
// import 'package:background_sms/background_sms.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../database_utils/group_database.dart';
// import '../../../../models/degree_model.dart';
// import '../../../../models/group_model.dart';
// import '../../../../models/stage_model.dart';
// import '../../../../models/student_model.dart';
//
// class AddDegreeBottomSheet extends StatefulWidget {
//   Student student;
//   Group group;
//   Stage stage;
//   String fStatus;
//   String subjectDropdownValue;
//
//   AddDegreeBottomSheet(this.student,this.group, this.stage,this.fStatus,this.subjectDropdownValue,{super.key});
//
//   @override
//   State<AddDegreeBottomSheet> createState() => _AddDegreeBottomSheetState();
// }
//
// String mark = '';
// String maxMark = '10';
// String? date;
// DateTime selectedDate = DateTime.now();
//
// class _AddDegreeBottomSheetState extends State<AddDegreeBottomSheet> {
//   // Telephony telephony = Telephony.instance;
//
//   String dropdownValue = 'Quiz';
//  String degreeTarget ='Excellent' ;
//
//   List<String> spinnerItems = [
//     'Quiz',
//     'H.W',
//     'Exam',
//   ];
//   List<String> subjectItems = [
//     'Maths',
//     'Apply',
//   ];
//
// int x =0;
//   GlobalKey<FormState> mykey = GlobalKey<FormState>();
//   TextEditingController markController = TextEditingController();
//   TextEditingController maxMarkController = TextEditingController(text: '10');
//    bool state1=true;
//
//    String  msg = ' ' ;
//    bool isPermit = true;
//
//
//   _getPermission() async => await [Permission.sms,].request();
//
//   Future<bool> _isPermissionGranted() async => await Permission.sms.status.isGranted;
//   StreamSubscription? connection;
//   bool isoffline = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     connection = Connectivity()
//         .onConnectivityChanged
//         .listen((ConnectivityResult result) {
//       // whenevery connection status is changed.
//       if (result == ConnectivityResult.none) {
//         //there is no any connection
//         setState(() {
//           isoffline = true;
//         });
//       } else if (result == ConnectivityResult.mobile) {
//         //connection is mobile data network
//         setState(() {
//           isoffline = false;
//         });
//       } else if (result == ConnectivityResult.wifi) {
//         //connection is from wifi
//         setState(() {
//           isoffline = false;
//         });
//       } else if (result == ConnectivityResult.ethernet) {
//         //connection is from wired connection
//         setState(() {
//           isoffline = false;
//         });
//       } else if (result == ConnectivityResult.bluetooth) {
//         //connection is from bluetooth threatening
//         setState(() {
//           isoffline = false;
//         });
//       } else if (result == ConnectivityResult.other) {
//         //connection is from bluetooth threatening
//         setState(() {
//           isoffline = true;
//         });
//       }
//     });
//
//   }
//   @override
//   void dispose() {
//     connection!.cancel();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     if(x==0){
//       x=1;
//       dropdownValue = widget.fStatus;
//     }
//     return isoffline == true?const ConnectionNetworkComponent():SingleChildScrollView(
//       child: Form(
//         key: mykey,
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           margin: const EdgeInsets.fromLTRB(2, 8, 2, 2),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Center(
//                   child: Text(
//                     'Add New Mark',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Theme
//                           .of(context)
//                           .colorScheme
//                           .primary,
//                       fontSize: 16,
//                     ),
//                   )),
//               Divider(
//                 color: Theme
//                     .of(context)
//                     .colorScheme
//                     .primary,
//                 thickness: 1,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               dropdownValue == 'H.W'
//                   ? Column(
//                     children: [
//                       Row(
//                 children: [
//                       Expanded(
//                         child: RadioListTile(
//                           title: const Text("Excellent"),
//                           value: "Excellent",
//                           activeColor: Colors.blue,
//                           groupValue: degreeTarget,
//                           onChanged: (value){
//                             setState(() {
//                               degreeTarget = value.toString();
//                               mark = value.toString();
//                             });
//                           },
//                         ),
//                       ),
//
//                       Expanded(
//                         child: RadioListTile(
//                           title: const Text("Very Good"),
//                           value: "Very Good",
//                           activeColor: Colors.blue,
//                           groupValue: degreeTarget,
//                           onChanged: (value){
//                             setState(() {
//                               degreeTarget = value.toString();
//                               mark = value.toString();
//                             });
//                           },
//                         ),
//                       ),
//                 ],
//               ),
//                       Row(children: [
//                         Expanded(
//                           child: RadioListTile(
//                             title: const Text("Good"),
//                             value: "Good",
//                             activeColor: Colors.blue,
//                             groupValue: degreeTarget,
//                             onChanged: (value){
//                               setState(() {
//                                 degreeTarget = value.toString();
//                                 mark = value.toString();
//                               });
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: RadioListTile(
//                             title: const Text("Fail"),
//                             value: "Fail",
//                             groupValue: degreeTarget,
//                             activeColor: Colors.blue,
//                             onChanged: (value){
//                               setState(() {
//                                 degreeTarget = value.toString();
//                                 mark = value.toString();
//                               });
//                             },
//                           ),
//                         ),
//                       ],)
//                     ],
//                   )
//                   : Column(
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(width: MediaQuery.of(context).size.width*0.01,),
//                           const Text('Degree : ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
//                           Expanded(
//                             child: TextFormField(
//                               maxLength: 4,
//                                  keyboardType: TextInputType.number,
//                                 decoration: InputDecoration(
//                               labelText: 'Mark',
//                               labelStyle: const TextStyle(
//                                 color: Color.fromRGBO(121, 121, 121, 1.0),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                               hintStyle: const TextStyle(
//                                   color: Color.fromRGBO(121, 121, 121, 1.0),
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.normal),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Theme.of(context).colorScheme.primary,),),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Theme
//                                       .of(context)
//                                       .colorScheme
//                                       .primary,
//                                 ),
//                               )),
//                 validator: (text) {
//                             if (text == null || text
//                                 .trim()
//                                 .isEmpty) {
//                               return 'Enter Degree';
//                             }
//                 },
//                 controller: markController,
//                 onChanged: (text) {
//                             mark = text;
//                 },
//               ),
//                           ),
//                           SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                           const Text('Max : ',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
//                           Expanded(
//                             child: TextFormField(
//                               maxLength: 4,
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   labelText: 'Max',
//                                   labelStyle: const TextStyle(
//                                     color: Color.fromRGBO(121, 121, 121, 1.0),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                   hintStyle: const TextStyle(
//                                       color: Color.fromRGBO(121, 121, 121, 1.0),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.normal),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme
//                                           .of(context)
//                                           .colorScheme
//                                           .primary,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Theme
//                                           .of(context)
//                                           .colorScheme
//                                           .primary,
//                                     ),
//                                   )),
//                               validator: (text) {
//                                 if (text == null || text
//                                     .trim()
//                                     .isEmpty) {
//                                   return 'Enter Max Degree';
//                                 }
//                               },
//                               controller: maxMarkController,
//                               onChanged: (text) {
//                                 maxMark = text;
//                               },
//
//                             ),
//                           ),
//                           SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                         ],
//                       ),
//                     ],
//                   ),
//               const SizedBox(
//                 height: 8,
//               ),
//
//               DropdownButton<String>(
//                 value: dropdownValue,
//                 icon: const Icon(Icons.arrow_drop_down),
//                 iconSize: 32,
//                 iconEnabledColor: Theme
//                     .of(context)
//                     .colorScheme
//                     .primary,
//                 isExpanded: true,
//                 focusColor: Colors.white,
//                 elevation: 16,
//                 style: TextStyle(
//                   color: Theme
//                       .of(context)
//                       .colorScheme
//                       .primary,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 onChanged: (txt) {
//                   dropdownValue = widget.fStatus;
//                   setState(() {
//                     dropdownValue = txt!;
//                   });
//                 },
//                 items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//
//              Container(
//                padding: const EdgeInsets.all(8),
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(12),
//                  color: Colors.cyan,
//                ),
//                  child: Center(child: Text(widget.subjectDropdownValue == 'Maths'? 'Maths':'Apply',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),))),
//               const SizedBox(
//                 height: 8,
//               ),
//               InkWell(
//                 onTap: () {
//                   showmydatepicker();
//                 },
//                 child: ListTile(
//                   leading: Icon(
//                     Icons.today,
//                     color: Theme
//                         .of(context)
//                         .colorScheme
//                         .primary,
//                   ),
//                   title: const Text(
//                     'Mark Date',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   subtitle: Text(
//                     '${selectedDate.day} / ${selectedDate.month} / ${selectedDate
//                         .year}',
//                     style: TextStyle(
//                       color: Theme
//                           .of(context)
//                           .colorScheme
//                           .primary,
//                     ),
//                   ),
//                   trailing: Icon(
//                     Icons.arrow_drop_down,
//                     color: Theme
//                         .of(context)
//                         .colorScheme
//                         .primary,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16,),
//               InkWell(
//                 onTap: (){
//                   if(widget.student.isSend!){
//                     widget.student.isSend = false;
//                     StudentDatabase.updateStudentInFirebase(widget.student);
//                     for(int i=0;i<widget.group.groupStudents!.length;i++){
//                       if(widget.group.groupStudents![i].studentDataBaseID==widget.student.studentDataBaseID){
//                         widget.group.groupStudents![i]= widget.student;
//                         GroupDatabase.updateGroupInFirebase(widget.group);
//                         break;
//                       }
//                     }
//                     for(int i=0;i<widget.stage.totalStudentsOfStage!.length;i++){
//                       if(widget.stage.totalStudentsOfStage![i].studentDataBaseID==widget.student.studentDataBaseID){
//                         widget.stage.totalStudentsOfStage![i]= widget.student;
//                         StageDatabase.updateStagesInFirebase(widget.stage);
//                         break;
//                       }
//                     }
//                   }
//                   else{
//                     widget.student.isSend = true;
//                     StudentDatabase.updateStudentInFirebase(widget.student);
//                     for(int i=0;i<widget.group.groupStudents!.length;i++){
//                       if(widget.group.groupStudents![i].studentDataBaseID==widget.student.studentDataBaseID){
//                         widget.group.groupStudents![i]= widget.student;
//                         GroupDatabase.updateGroupInFirebase(widget.group);
//                         break;
//                       }
//                     }
//                     for(int i=0;i<widget.stage.totalStudentsOfStage!.length;i++){
//                       if(widget.stage.totalStudentsOfStage![i].studentDataBaseID==widget.student.studentDataBaseID){
//                         widget.stage.totalStudentsOfStage![i]= widget.student;
//                         StageDatabase.updateStagesInFirebase(widget.stage);
//                         break;
//                       }
//                     }
//                   }
//                   setState(() {
//
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color:  widget.student.isSend!?Colors.green:Colors.red,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text('SMS  ',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
//                       widget.student.isSend!?const Text('ON',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),):const Text('OFF',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32,),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   padding: const MaterialStatePropertyAll(EdgeInsets.all(4),),
//                   backgroundColor: MaterialStatePropertyAll(
//                       Theme
//                           .of(context)
//                           .colorScheme
//                           .primary),
//                 ),
//                 onPressed: () {
//
//                   print('omar ${widget.group.groupMaxQuizzes}');
//                       if(dropdownValue == 'H.W'){
//                         print('omar1 hw');
//                         if(widget.subjectDropdownValue == 'Maths' ){
//                           print('omar2 hw');
//                           if(widget.student.totalCompleteHw == widget.group.groupMaxHw){
//                             print('omar3 hw');
//                             showDialog(
//                               context: context,
//                               barrierDismissible: false,
//                               builder: (context) {
//                                 return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Add New H.W To Group',);
//                               },
//                             );
//                           }else{
//                             print('omar4 hw');
//                             ///todo: validate
//                             validate();
//                           }
//                         }
//                         else if(widget.subjectDropdownValue == 'Apply'){
//                           if(widget.student.totalCompleteApplyHw == widget.group.groupMaxApplyHw){
//                             showDialog(
//                               context: context,
//                               barrierDismissible: false,
//                               builder: (context) {
//                                 return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Add New H.W To Group',);
//                               },
//                             );
//                           }else{
//                             ///todo: validate
//                             validate();
//                           }
//                         }
//                       }
//                       else if(dropdownValue == 'Quiz'){
//                           if(widget.subjectDropdownValue == 'Maths' ){
//                             if(widget.student.totalCompleteQuiz == widget.group.groupMaxQuizzes ){
//                               showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (context) {
//                                   return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Add New Quiz To Group',);
//                                 },
//                               );
//                             }else{
//                               ///todo: validate
//                               checkPrmit();
//                             }
//                           }
//                           else if(widget.subjectDropdownValue == 'Apply'){
//                             if(widget.student.totalCompleteApplyQuiz == widget.group.groupMaxApplyQuizzes){
//                               showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (context) {
//                                   return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Add New Quiz To Group',);
//                                 },
//                               );
//                             }else{
//                               ///todo: validate
//                               checkPrmit();
//                             }
//                           }
//                     }
//                       else if(dropdownValue =='Exam'){
//                         if(widget.subjectDropdownValue == 'Maths' ){
//                           if(widget.student.totalCompleteExam == widget.group.groupMaxExams ){
//                             showDialog(
//                               context: context,
//                               barrierDismissible: false,
//                               builder: (context) {
//                                 return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Add New Exam To Group',);
//                               },
//                             );
//                           }else{
//                             ///todo: validate
//                             checkPrmit();
//
//                           }
//                         }
//                         else if(widget.subjectDropdownValue == 'Apply'){
//                           if(widget.student.totalCompleteApplyExam == widget.group.groupMaxApplyExams){
//                             showDialog(
//                               context: context,
//                               barrierDismissible: false,
//                               builder: (context) {
//                                 return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Add New Exam To Group',);
//                               },
//                             );
//                           }else{
//                             ///todo: validate
//                             checkPrmit();
//                           }
//                         }
//                       }
//
//                 },
//                 child: const Text(
//                   'Save ',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void validate() async{
//     if (mykey.currentState!.validate()) {
//       Navigator.pop(context);
//       if(widget.subjectDropdownValue == 'Apply'){
//         if (dropdownValue == 'Quiz') {
//           widget.student.totalCompleteApplyQuiz = widget.student.totalCompleteApplyQuiz! +1;
//         } else if (dropdownValue == 'H.W') {
//           widget.student.totalCompleteApplyHw=widget.student.totalCompleteApplyHw!+1;
//         } else if (dropdownValue == 'Exam') {
//           widget.student.totalCompleteApplyExam=widget.student.totalCompleteApplyExam! +1;
//         }
//
//       }
//       else if(widget.subjectDropdownValue == 'Maths'){
//         if (dropdownValue == 'Quiz') {
//           widget.student.totalCompleteQuiz = widget.student.totalCompleteQuiz! +1;
//         } else if (dropdownValue == 'H.W') {
//           widget.student.totalCompleteHw=widget.student.totalCompleteHw!+1;
//         } else if (dropdownValue == 'Exam') {
//           widget.student.totalCompleteExam=widget.student.totalCompleteExam! +1;
//         }
//
//       }
//
//       String v = mark.replaceAll('-', '');
//       String vm = maxMark.replaceAll('-', '');
//
//
//       Degree degree = Degree(
//         subjectType: widget.subjectDropdownValue,
//           typeDegree: dropdownValue,
//           degree: dropdownValue=='H.W'? degreeTarget : '$v/$vm',
//           dateDegree:
//           '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
//           isSend: false
//       );
//       widget.student.studentDegrees?.add(degree);
//       StudentDatabase.updateStudentInFirebase(widget.student);
//
//       msg =
//       '${widget.student.studentName}\n'
//           'Grade: ${widget.student.stageNameOfStudent}\n'
//           '${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].typeDegree} Mark ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].dateDegree} : ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].degree}\n'
//           'Dr. Mohamed Gamal';
//
//       double r=0.0;
//       double max = 0.0;
//       double res = 0.0;
//
//        if(dropdownValue=='Quiz'){
//
//           r = double.parse(v);
//           max = double.parse(vm);
//          res =0.0;
//
//
//         if(v.isEmpty ||vm.isEmpty){
//           degree.degree='0.0';
//           r = 0.0;
//           max= 0.0;
//           res =0.0;
//         }
//         else{
//           r = double.parse(v);
//           max = double.parse(vm);
//           res =(r/max)*100;
//         }
//
//
//         if(res>=80 && res <= 100 ){
//
//           msg =
//               '${widget.student.studentName}\n'
//               'Grade: ${widget.student.stageNameOfStudent}\n'
//               '${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].typeDegree} Mark ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].dateDegree} : ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].degree}\n'
//               'Dr. Mohamed Gamal';
//         }
//         else if(res >= 50 && res < 80){
//           msg =
//           '${widget.student.studentName}\n'
//               'Grade: ${widget.student.stageNameOfStudent}\n'
//               '${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].typeDegree} Mark ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].dateDegree} : ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].degree}\n'
//               'Dr. Mohamed Gamal';
//
//         }
//         else if(res <= 50){
//           msg =
//           '${widget.student.studentName}\n'
//               'Grade: ${widget.student.stageNameOfStudent}\n'
//               '${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].typeDegree} Mark ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].dateDegree} : ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].degree}\n'
//               'Dr. Mohamed Gamal';
//
//
//         }
//       }
//       else if(dropdownValue=='Exam'){
//          msg =
//          '${widget.student.studentName}\n'
//              'Grade: ${widget.student.stageNameOfStudent}\n'
//              '${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].typeDegree} Mark ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].dateDegree} : ${widget.student.studentDegrees![widget.student.studentDegrees!.length-1].degree}\n'
//              'Dr. Mohamed Gamal';
//       }
//
//       if(widget.student.isSend! == true) {
//         if (dropdownValue == 'Quiz' || dropdownValue == 'Exam') {
//           if(widget.student.studentParentPhoneNumber!.length==11){
//             if (await _isPermissionGranted()) {
//               var result = await BackgroundSms.sendMessage(
//                 phoneNumber: "${widget.student.studentParentPhoneNumber}", message: msg,);
//               if (result == SmsStatus.sent) {
//                 widget.student.studentDegrees![widget.student.studentDegrees!.length-1].isSend = true;
//                 StudentDatabase.updateStudentInFirebase(widget.student);
//               } else {
//                 widget.student.studentDegrees![widget.student.studentDegrees!.length-1].isSend = false;
//                 StudentDatabase.updateStudentInFirebase(widget.student);
//               }
//             }
//             else{
//               _getPermission();
//             }
//           }
//
//         }
//       }
//
//       for(int i=0;i<widget.stage.totalGroupsOfStage!.length;i++){
//         for(int j=0;j<widget.stage.totalGroupsOfStage![i].groupStudents!.length;j++){
//           if(widget.stage.totalGroupsOfStage![i].groupStudents![j].studentDataBaseID==widget.student.studentDataBaseID){
//             widget.stage.totalGroupsOfStage![i].groupStudents![j]=widget.student;
//             break;
//           }
//         }
//       }
//       GroupDatabase.updateGroupInFirebase(widget.group);
//       StageDatabase.updateStagesInFirebase(widget.stage);
//
//       for(int i=0;i<widget.stage.totalStudentsOfStage!.length;i++){
//         if(widget.stage.totalStudentsOfStage![i].studentDataBaseID==widget.student.studentDataBaseID){
//           widget.stage.totalStudentsOfStage![i]=widget.student;
//           break;
//         }
//       }
//       StageDatabase.updateStagesInFirebase(widget.stage);
//
//
//
//     }
//   }
//
//   void checkPrmit(){
//     String v = mark.replaceAll('-', '');
//     String vm = maxMark.replaceAll('-', '');
//     if(v.contains('..')||v.contains('...')||v.contains('....')
//         ||vm.contains('..')||vm.contains('...')||vm.contains('....')
//         ||v.contains('-')||v.contains('--')||v.contains('---')||v.contains('----')
//         ||vm.contains('-')||vm.contains('--')||vm.contains('---')||vm.contains('----')
//         ||v =='.'||vm=='.'||v.isEmpty||vm.isEmpty){
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) {
//           return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Pleas Enter Correct Mark',);
//         },
//       );
//     }else{
//       double r = double.parse(v);
//       double max = double.parse(vm);
//       if(r>max){
//         showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) {
//             return   AlertDialogOkComponent(alertTitle: 'Note!',alertContent: 'Pleas Enter Correct Mark',);
//           },
//         );
//       }
//       else{
//         validate();
//       }
//     }
//   }
//
//   void showmydatepicker() async {
//     final DateTime picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now().subtract(const Duration(days: 365)),
//       lastDate: selectedDate.add(const Duration(days: 365)),
//     ) ??
//         DateTime.now();
//     if (picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
// }
