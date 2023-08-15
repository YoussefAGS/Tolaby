// import 'dart:io';
// import 'package:assistant/models/degree_model.dart';
// import 'package:assistant/models/student_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share/share.dart';
// import '../../../../shared/constants/constant.dart';
// import 'package:pdf/widgets.dart' as pw;
// import '../../../qr_pdf/pdf_preview_screen.dart';
//
// class StudentWorksView extends StatefulWidget {
//   static const String routeName = 'Student Works View';
//    const StudentWorksView({Key? key}) : super(key: key);
//
//   @override
//   State<StudentWorksView> createState() => _StudentWorksViewState();
// }
//
// class _StudentWorksViewState extends State<StudentWorksView> {
//   ScreenshotController screenshotController = ScreenshotController();
//
//   late Student student;
//   @override
//   Widget build(BuildContext context) {
//
//     student = ModalRoute.of(context)!.settings.arguments as Student;
//     return Scaffold(
//       backgroundColor: primaryColorDark,
//       appBar: AppBar(
//         title:const Text('Report') ,
//         actions: [
//           IconButton(
//               onPressed: (){
//             convertWidgetToImage();
//           }, icon: const Icon(Icons.screenshot,color: Colors.white,size: 28,)),
//           IconButton(onPressed: (){
//             displayPdfForDegrees();
//           }, icon: const Icon(Icons.print,color: Colors.white,size: 28,))
//
//         ],
//       ),
//       body: Screenshot(
//         controller: screenshotController,
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [ Colors.purple, Colors.blue.shade900],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Divider(thickness: 1,color: Colors.white,),
//                 const Center(child: Text('Dr/ Mohamed Gamal',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,maxLines: 1,)),
//                 const Divider(thickness: 1,color: Colors.white,),
//                 const SizedBox(height: 8,),
//                 Center(child: Text('${student.studentCompleteId} ${student.studentName} ',style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,maxLines: 1,)),
//                 const SizedBox(height: 16,),
//                 Center(child: Text('${student.stageNameOfStudent} - ${student.groupNameOfStudent} ',style: const TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 1,),),
//                 const SizedBox(height: 8,),
//                 const Divider(thickness: 1,color: Colors.white,),
//                 const SizedBox(height: 8,),
//                 const Center(child: Text('Degrees',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),),
//                 const SizedBox(height: 16,),
//                 DataTable(
//                   border: TableBorder.all(color: Colors.white),
//                   columns: const [
//                     DataColumn(label: Text('Date',style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)),
//                     DataColumn(label: Text('T',style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)),
//                     DataColumn(label: Text('Degree',style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,)),
//                     DataColumn(label: Text('Sent',style: TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis)),
//                   ],
//                   rows: List<DataRow>.generate(
//                     student.studentDegrees!.length,
//                         (index) => DataRow(
//                       cells: [
//                         DataCell(Text('${student.studentDegrees![index].dateDegree}',style: const TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),)),
//                         DataCell(Text(student.studentDegrees![index].typeDegree!.substring(0,1),style: const TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),)),
//                         DataCell(Text('${student.studentDegrees![index].degree}\n${student.studentDegrees![index].subjectType}',style: const TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),)),
//                         DataCell(student.studentDegrees![index].isSend==false?const Icon(Icons.dangerous_outlined,color: Colors.redAccent,size: 24,):const Icon(Icons.done,color: Colors.lightGreenAccent,size: 24,)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//               ],
//             ),
//           ),
//         ),
//       )
//     );
//   }
//
//
//
//
//
//
//   void convertWidgetToImage() async {
//     await screenshotController.capture(delay: const Duration(milliseconds: 10))
//         .then((Uint8List? image) async {
//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/Report : ${student.studentCompleteId} ${student.studentName}.png').create();
//         await imagePath.writeAsBytes(image);
//         /// Share Plugin
//         await Share.shareFiles([imagePath.path],text: 'Report : ${student.studentCompleteId} ${student.studentName}');
//
//       }
//     });
//   }
//
//
//
//
//
//
//
//
//   Future<void> createAndPrintStudentProfilePdf() async {
//     final pdf = pw.Document();
//     const int degreesPerPage = 20; // Number of students per page
//     const int DegreesPerRow = 1; // Number of students per row
//     const int maxStudents = 800; // Maximum number of students across all pages
//
//     // Calculate the number of pages needed based on the number of students
//     int totalPages = (student.studentDegrees!.length / degreesPerPage).ceil();
//     if (totalPages > (maxStudents / degreesPerPage).ceil()) {
//       // Limit the total number of pages to `maxStudents / studentsPerPage`
//       totalPages = (maxStudents / degreesPerPage).ceil();
//     }
//     for (int page = 0; page < totalPages; page++) {
//       pdf.addPage(
//         pw.MultiPage(
//           textDirection: pw.TextDirection.rtl,
//           pageFormat: PdfPageFormat.a4,
//           build: (context) {
//             List<pw.TableRow> currentPageData = List.generate(
//               (degreesPerPage / DegreesPerRow).ceil(),
//                   (rowIndex) {
//                 int startIndex = page * degreesPerPage + rowIndex * DegreesPerRow;
//                 int endIndex = startIndex + DegreesPerRow;
//                 if (startIndex >= student.studentDegrees!.length) {
//                   // Return an empty row if no more students
//                   return const pw.TableRow(children: []);
//                 }
//                 if (endIndex > student.studentDegrees!.length) {
//                   endIndex = student.studentDegrees!.length;
//                 }
//
//                 List<pw.Widget> rowChildren = [];
//                 for (int i = startIndex; i < endIndex; i++) {
//                   Degree degree = student.studentDegrees![i];
//
//                   rowChildren.add(
//                     pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                               '${degree.subjectType!} ',
//                               style: const pw.TextStyle(
//                                 fontSize: 13,
//                               ),
//                               textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//
//                             textAlign: pw.TextAlign.center
//                           ),
//
//                           pw.Text(
//                               '${degree.dateDegree!} ',
//                               style: const pw.TextStyle(
//                                 fontSize: 13,
//
//                               ),
//                               textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//
//                               textAlign: pw.TextAlign.center
//
//                           ),
//
//                           pw.Text(
//                               '${degree.typeDegree!} ',
//                               style: const pw.TextStyle(
//                                 fontSize: 13,
//                               ),
//                               textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                               maxLines: 1,
//                               textAlign: pw.TextAlign.center
//
//                           ),
//
//
//                           pw.Text(
//                               '${degree.degree!} ',
//                               style: const pw.TextStyle(
//                                 fontSize: 13,
//
//                               ),
//                               textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                               textAlign: pw.TextAlign.center
//
//                           ),
//
//
//                           pw.Text(
//                               ' ${degree.isSend!?'YES':'NO'} ',
//                               style: const pw.TextStyle(
//                                 fontSize: 13,
//                               ),
//                               textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//
//                           ),
//
//                         ],
//                       ),
//
//
//                   );
//                 }
//
//                 return pw.TableRow(
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border.all(color: PdfColors.blue900,width: 1),
//                   ),
//                   children: rowChildren.map((child) => pw.Container(child: child)).toList(),
//                 );
//               },
//             );
//
//             return [
//               pw.Table(
//                 border: const pw.TableBorder(verticalInside: pw.BorderSide(color: PdfColors.blue900,width: 1),horizontalInside: pw.BorderSide(color: PdfColors.blue900,width: 1) ),
//                 children: [
//                   pw.TableRow(
//                     children: [
//                       pw.Row(
//                           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Text(
//                             'Subject',
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//
//                           ),
//                           pw.Text(
//                             'Date',
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               fontWeight: pw.FontWeight.bold,
//
//                             ),
//                           ),
//
//
//                           pw.Text(
//                             'Type',
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               fontWeight: pw.FontWeight.bold,
//
//                             ),
//                           ),
//
//                           pw.Text(
//                             'Degree',
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               fontWeight: pw.FontWeight.bold,
//
//                             ),
//                           ),
//
//                           pw.Text(
//                             'Sent',
//                             style: pw.TextStyle(
//                               fontSize: 16,
//                               fontWeight: pw.FontWeight.bold,
//                             ),
//                           ),
//
//                         ]
//                       ),
//                     ],
//                   ),
//                   pw.TableRow(
//                     children: [
//                       pw.SizedBox(height: 8),
//                     ]
//                   ),
//                   ...currentPageData,
//                 ],
//               ),
//             ];
//           },
//         ),
//       );
//
//       /// open Preview Screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PreviewScreen(
//             doc: pdf,
//             groupName: "${student.groupNameOfStudent}",
//             stageName: "${student.stageNameOfStudent}",
//           ),
//         ),
//       );
//
//     }
//
//
//
//
//
//
//     // final output = await getTemporaryDirectory();
//     // final file = File('${output.path}/example.pdf');
//     // await file.writeAsBytes(await pdf.save());
//     // await Printing.layoutPdf(
//     //     onLayout: (PdfPageFormat format) async => pdf.save());
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   Future<void> displayPdfForDegrees() async {
//     if(student.studentDegrees!.length<=50){
//       final pdf = pw.Document();
//       final pdf2 = pw.Document();
//       if(student.studentDegrees!.length<=22){
//         pdf.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a4,
//             build: (context) {
//               return pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Dr / MOHAMED GAMAL - Maths',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Student : ${student.studentCompleteId} ${student.studentName}',
//                     style: pw.TextStyle(
//
//                       fontSize: 20,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Total Degrees : ${student.studentDegrees!.length} ',
//                     style: pw.TextStyle(
//
//                       fontSize: 20,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Table.fromTextArray(
//                     headerStyle: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     cellAlignment: pw.Alignment.center,
//                     data: [
//                       ['Date', 'Subject','Type', 'Degree', 'Sent'],
//                       ...student.studentDegrees!.map((degree) => [
//                         degree.dateDegree,
//                         degree.subjectType,
//                         degree.typeDegree,
//                         degree.degree,
//                         degree.isSend! ?'YES':'NO',
//                       ])
//                     ],
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//
//         final output = await getTemporaryDirectory();
//         final file1 = File('${output.path}/Report 1 : ${student.studentCompleteId} ${student.studentName}.pdf');
//         await file1.writeAsBytes(await pdf.save());
//
//
//
//
//
//         /// Share Plugin
//         await Share.shareFiles([file1.path,],text: 'Report : ${student.studentCompleteId} ${student.studentName}');
//
//       }
//       if(student.studentDegrees!.length>=23){
//         List<Degree> adeg = [] ;
//         List<Degree> adeg2 = [] ;
//         for(int i = 0;i<=22;i++){
//           adeg2.add(student.studentDegrees![i]);
//         }
//         for(int j = 23;j<student.studentDegrees!.length;j++){
//           adeg.add(student.studentDegrees![j]);
//         }
//         pdf.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a4,
//             build: (context) {
//               return pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Dr / MOHAMED GAMAL - Maths',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Student : ${student.studentCompleteId} ${student.studentName}',
//                     style: pw.TextStyle(
//
//                       fontSize: 20,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Total Degrees : ${student.studentDegrees!.length} ',
//
//                     style: pw.TextStyle(
//
//                       fontSize: 20,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Table.fromTextArray(
//                     headerStyle: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     cellAlignment: pw.Alignment.center,
//                     data: [
//                       ['Date', 'Subject','Type', 'Degree', 'Sent'],
//                       ...adeg2.map((degree) => [
//                         degree.dateDegree,
//                         degree.subjectType,
//                         degree.typeDegree,
//                         degree.degree,
//                         degree.isSend! ?'YES':'NO',
//                       ])
//                     ],
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//
//         pdf2.addPage(
//           pw.Page(
//             pageFormat: PdfPageFormat.a4,
//             build: (context) {
//               return pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Dr / MOHAMED GAMAL - Maths',
//                     textAlign: pw.TextAlign.center,
//                     style: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Student : ${student.studentCompleteId} ${student.studentName}',
//                     style: pw.TextStyle(
//
//                       fontSize: 20,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                   ),
//                   pw.SizedBox(height: 10),
//                   pw.Text(
//                     'Total Degrees : ${student.studentDegrees!.length} ',
//                     style: pw.TextStyle(
//
//                       fontSize: 20,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//                   ),
//                   pw.SizedBox(height: 20),
//                   pw.Table.fromTextArray(
//                     headerStyle: pw.TextStyle(
//                       fontSize: 16,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                     cellAlignment: pw.Alignment.center,
//                     data: [
//                       ['Date', 'Subject','Type', 'Degree', 'Sent'],
//                       ...adeg.map((degree) => [
//                         degree.dateDegree,
//                         degree.subjectType,
//                         degree.typeDegree,
//                         degree.degree,
//                         degree.isSend! ?'YES':'NO',
//                       ])
//                     ],
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//
//         final output = await getTemporaryDirectory();
//         final file1 = File('${output.path}/Report 1 : ${student.studentCompleteId} ${student.studentName}.pdf');
//         await file1.writeAsBytes(await pdf.save());
//         final file2 = File('${output.path}/Report 2 : ${student.studentCompleteId} ${student.studentName}.pdf');
//         await file2.writeAsBytes(await pdf2.save());
//
//
//
//         /// Share Plugin
//         await Share.shareFiles([file1.path,file2.path],text: 'Report : ${student.studentCompleteId} ${student.studentName}');
//
//       }
//
//
//
//
//
//       // // open Preview Screen
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => PreviewScreen(
//       //       doc: pdf,
//       //       groupName: "${student.groupNameOfStudent}",
//       //       stageName: "${student.stageNameOfStudent}",
//       //     ),
//       //   ),
//       // );
//     }
//
//   }
//
//
// }
