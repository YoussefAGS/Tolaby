// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// import '../../../../models/student_model.dart';
//
// class StudentCard extends StatelessWidget {
//   Student student;
//
//   StudentCard(this.student, {super.key});
//   GlobalKey globalKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               QrImageView(
//                 data: '${ student.studentCompleteId}',
//                 version: QrVersions.auto,
//                 dataModuleStyle: QrDataModuleStyle(color: Theme
//                     .of(context)
//                     .colorScheme
//                     .primary),
//                 constrainErrorBounds: true,
//                 eyeStyle: QrEyeStyle(color: Theme
//                     .of(context)
//                     .colorScheme
//                     .primary, eyeShape: QrEyeShape.square),
//                 backgroundColor: Colors.white,
//                 padding: const EdgeInsets.all(6),
//                 embeddedImageEmitsError: true,
//                 errorCorrectionLevel: 1,
//                 foregroundColor: Colors.lightBlue.shade700,
//                 errorStateBuilder: (context, error) =>
//                     const Text('errorsssss'),
//                 semanticsLabel: '${ student.studentName}',
//                 size: 200,
//                 gapless: true,
//               ),
//               const SizedBox(height: 50),
//               Container(
//                 height: 150,
//                 width: 300,
//                 padding: const EdgeInsets.only(right: 16,left: 16,bottom: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   gradient: const LinearGradient(
//                     colors: [Colors.cyan, Colors.blue],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(width: 4,),
//                           Expanded(
//                             flex: 2,
//                             child: Text('${student.studentCompleteId}',
//                               style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   overflow: TextOverflow.ellipsis,
//                                   color: Colors.white
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 5,
//                             child: Text('${student.studentName}',
//                               style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   overflow: TextOverflow.ellipsis,
//                                   color: Colors.white
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Expanded(
//                       child: Text('Stage : ${ student.stageNameOfStudent}',
//                         style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                             color: Colors.white
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text('Group : ${ student.groupNameOfStudent}',
//                         style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                             color: Colors.white
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Text('Subject: ${student.studentSubjects![0]}',
//                         style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                             color: Colors.white
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//     );
//   }
//
// }
