// import 'package:assistant/shared/constants/constant.dart';
// import 'package:assistant/ui/teacher/student/student_profile/profile_view.dart';
// import 'package:flutter/material.dart';
// import '../student_item.dart';
// import 'Quiz_view.dart';
// import 'exam_view.dart';
// import 'hw_view.dart';
//
//
// class StudentDetails extends StatefulWidget {
//   static const String routeName = 'Student Details';
//
//   const StudentDetails({super.key});
//
//   @override
//   State<StudentDetails> createState() => _StudentDetailsState();
// }
//
// class _StudentDetailsState extends State<StudentDetails> {
//
//   late AllStudentAndGroup studentwgroup;
//   String fs = 'Quiz';
//
//   @override
//   Widget build(BuildContext context) {
//
//     studentwgroup = ModalRoute.of(context)!.settings.arguments as AllStudentAndGroup;
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Scaffold(
//         backgroundColor: primaryColorDark,
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor:primaryColorDark,
//           title: Text(
//             '${studentwgroup.st.studentCompleteId} ${studentwgroup.st.studentName}',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//         ),
//
//         body: DefaultTabController(
//           length: 4,
//           child: Column(
//             children: [
//
//               const TabBar(
//                 indicatorColor: Colors.blue,
//                 tabs: [
//                   Tab(child: Text('Profile',style: TextStyle(color: Colors.white,fontSize: 12),),),
//                   Tab(child: Text('Quizzes',style: TextStyle(color: Colors.white,fontSize: 12),),),
//                   Tab(child: Text('H . W',style: TextStyle(color:Colors.white,fontSize: 12)),),
//                   Tab(child: Text('Exam',style: TextStyle(color: Colors.white,fontSize: 12),),),
//                 ],
//               ),
//               Expanded(
//                 child: Card(
//                   elevation: 33,
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(12),
//                     decoration:   const BoxDecoration(
//                       color: primaryColorDark,
//                     ),
//                     child: TabBarView(
//                       children: [
//                          ProfileView(studentwgroup.st,studentwgroup.gr,studentwgroup.sta,studentwgroup.dropdownValue),
//                         QuizView(studentwgroup.st,studentwgroup.gr,studentwgroup.sta,studentwgroup.dropdownValue),
//                         HwView(studentwgroup.st,studentwgroup.gr,studentwgroup.sta,studentwgroup.dropdownValue),
//                         ExamView(studentwgroup.st,studentwgroup.gr,studentwgroup.sta,studentwgroup.dropdownValue),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
// }
//
// // void _showScaffold(String message) {
// //   _scaffoldKey.currentState.showSnackBar(SnackBar(
// //     content: Text(message),
// //   ));
// // }