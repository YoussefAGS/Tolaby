// import 'dart:io';
// import 'dart:typed_data';
// import 'package:assistant/models/attendance_model.dart';
// import 'package:assistant/models/student_model.dart';
// import 'package:assistant/shared/constants/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share/share.dart';
// import 'package:pdf/widgets.dart' as pw;
//
//
// class StudentAttendancesView extends StatefulWidget {
//   static const String routeName = 'Student Attendances View';
//    const StudentAttendancesView({Key? key}) : super(key: key);
//
//   @override
//   State<StudentAttendancesView> createState() => _StudentAttendancesViewState();
// }
//
// class _StudentAttendancesViewState extends State<StudentAttendancesView> {
//   ScreenshotController screenshotController = ScreenshotController();
//
// late   Student student;
//
//   static late pw.Font arFont;
//   init() async {
//     arFont = pw.Font.ttf(
//         await rootBundle.load('assets/fonts/Cairo/static/Cairo-Bold.ttf'));
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     init();
//   }
//   @override
//   Widget build(BuildContext context) {
//      student = ModalRoute.of(context)!.settings.arguments as Student;
//     return Scaffold(
//       backgroundColor: primaryColorDark,
//       appBar: AppBar(
//         title:const Text('Report') ,
//         actions: [
//           IconButton(
//               onPressed: (){
//                 convertWidgetToImage();
//               }, icon: const Icon(Icons.screenshot,color: Colors.white,size: 28,)),
//           IconButton(onPressed: (){
//             displayPdfForAttendances();
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
//                 const Center(child: Text('Attendances',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),),
//                 const SizedBox(height: 16,),
//                 DataTable(
//                   border: TableBorder.all(color: Colors.white),
//                   columns: const [
//                     DataColumn(label: Text('Subject',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),)),
//                     DataColumn(label: Text('Date',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),)),
//                     DataColumn(label: Text('Attend',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold))),
//                   ],
//                   rows: List<DataRow>.generate(
//                     student.studentAttendances!.length,
//                         (index) => DataRow(
//                       cells: [
//                         DataCell(Text('Session  ${index+1}  ${student.studentAttendances![index].sessionType}',style: const TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),)),
//                         DataCell(Text('${student.studentAttendances![index].lessonDate}',style: const TextStyle(color: Colors.white,fontSize: 11,fontWeight: FontWeight.bold),)),
//                         DataCell(student.studentAttendances![index].isAttend==false?const Icon(Icons.dangerous_outlined,color: Colors.red,size: 24,):const Icon(Icons.done,color: Colors.lightGreenAccent,size: 28,)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20,),
//             ],),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void convertWidgetToImageToanyNum() async {
//     await screenshotController.capture(delay: const Duration(milliseconds: 10))
//         .then((Uint8List? image) async {
//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/Report: ${student.studentCompleteId} ${student.studentName}.png').create();
//         await imagePath.writeAsBytes(image);
//         /// Share Plugin
//         await Share.shareFiles([imagePath.path],text: 'Report: ${student.studentCompleteId} ${student.studentName}',);
//       }
//     });
//   }
//
//   void convertWidgetToImage() async {
//     await screenshotController.capture(delay: const Duration(milliseconds: 10))
//         .then((Uint8List? image) async {
//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/image.png').create();
//         await imagePath.writeAsBytes(image);
//
//         /// Share Plugin
//         await Share.shareFiles([imagePath.path], text: '');
//       }
//
//     });
//   }
//
//   Future<void> createAndPrintStudentProfilePdf() async {
//     final pdf = pw.Document();
//     pdf.addPage(pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Column(
//               children: [
//
//               ]
//           );// Center
//         }));
//     final output = await getTemporaryDirectory();
//     final file = File('${output.path}/example.pdf');
//     await file.writeAsBytes(await pdf.save());
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdf.save());
//   }
//
//
//
//   Future<void> displayPdfForAttendances() async {
//     if(student.studentAttendances!.length<=45){
//       final pdf = pw.Document();
//       final pdf2 = pw.Document();
//       if(student.studentAttendances!.length<=22){
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
//                     'Total Attendances : ${student.studentAttendances!.length} ',
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
//                       ['Subject', 'Date','Attend', ],
//                       ...student.studentAttendances!.map((degree) => [
//                         degree.sessionType,
//                         degree.lessonDate,
//                         degree.isAttend! ?'YES':'NO',
//
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
//         List<Attendance> adeg = [] ;
//         List<Attendance> adeg2 = [] ;
//         for(int i = 0;i<=22;i++){
//           adeg2.add(student.studentAttendances![i]);
//         }
//         for(int j = 23;j<student.studentDegrees!.length;j++){
//           adeg.add(student.studentAttendances![j]);
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
//                     'Total Attendances : ${student.studentDegrees!.length} ',
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
//                       ['Subject', 'Date','Attend', ],
//                       ...student.studentAttendances!.map((degree) => [
//                         degree.sessionType,
//                         degree.lessonDate,
//                         degree.isAttend! ?'YES':'NO',
//
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
//                     'Total Attendances : ${student.studentDegrees!.length} ',
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
//                       ['Subject', 'Date','Attend', ],
//                       ...student.studentAttendances!.map((degree) => [
//                         degree.sessionType,
//                         degree.lessonDate,
//                         degree.isAttend! ?'YES':'NO',
//
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
// }
