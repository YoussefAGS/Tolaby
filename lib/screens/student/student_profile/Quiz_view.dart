// import 'dart:async';
//
// import 'package:assistant/database_utils/student_database.dart';
// import 'package:assistant/shared/components/connection_networ_component.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../models/group_model.dart';
// import '../../../../models/stage_model.dart';
// import '../../../../models/student_model.dart';
// import '../degree/add_degree_bottomsheet.dart';
// import '../degree/degree_item.dart';
//
//
// class QuizView extends StatefulWidget {
// Student student ;
// Group group;
// Stage stage;
// String dropdownValue;
//
// QuizView(this.student,this.group, this.stage,this.dropdownValue,{super.key});
//
//   @override
//   State<QuizView> createState() => _QuizViewState();
// }
//
// class _QuizViewState extends State<QuizView> {
//   String fQuiz = 'Quiz';
//  late List<Student>? studentdeg;
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
//     return isoffline == true?const ConnectionNetworkComponent():Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
//       floatingActionButton: FloatingActionButton.extended(
//         splashColor: Colors.red,
//         elevation: 2,
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         onPressed: () {
//           showDegreeBottomsheet();
//           setState(() {
//
//           });
//         },
//         label: const Text(
//           'New Quiz',
//           style: TextStyle(fontSize: 12,color: Colors.white),
//         ),
//         icon: const Icon(Icons.add, size: 22,color: Colors.white),
//       ),
//
//       body: widget.dropdownValue == 'Maths' ?
//       Container(
//         margin: const EdgeInsets.only(right: 2,left: 2,bottom: 50),
//
//         child: StreamBuilder<QuerySnapshot<Student>>(
//           stream: StudentDatabase.readStudentsWorkFormFirebase(widget.student),
//           builder:(context,snapshot){
//             if (snapshot.hasData) {
//               studentdeg = snapshot.data?.docs.map((e) => e.data()).toList();
//               return  ListView.builder(
//                 itemCount: studentdeg![0].studentDegrees!.length,
//                 itemBuilder: (context, index) {
//                   if(studentdeg![0].studentDegrees![index].typeDegree=='Quiz'&&studentdeg![0].studentDegrees![index].subjectType==widget.dropdownValue){
//                     return degreeItem(studentdeg![0].studentDegrees![index], widget.student, index,widget.stage,widget.group);
//                   }
//                   else if(studentdeg![0].studentDegrees![index].typeDegree=='Apply'&&studentdeg![0].studentDegrees![index].subjectType==widget.dropdownValue){
//                     return degreeItem(studentdeg![0].studentDegrees![index], widget.student, index,widget.stage,widget.group);
//                   }
//                return const SizedBox(height: 0,);
//                 });
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ):const SizedBox(height: 0,),
//     );
//   }
//   void showDegreeBottomsheet(){
//     showModalBottomSheet(context: context,isScrollControlled: true, builder: (context){
//       return Padding(
//         padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: AddDegreeBottomSheet(widget.student,widget.group,widget.stage,fQuiz,widget.dropdownValue),
//       );
//     });
//   }
// }
