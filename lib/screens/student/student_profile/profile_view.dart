// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share/share.dart';
//
// import 'package:path_provider/path_provider.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:tolaby/utiles/constant.dart';
//
// import '../../../modles/attendance_model.dart';
// import '../../../modles/group_model.dart';
// import '../../../modles/stage_model.dart';
// import '../../../modles/student_model.dart';
//
//
// class ProfileView extends StatefulWidget {
//   Student student;
//   Group group;
//   Stage stage;
//   String dropdownValue;
//
//   ProfileView(this.student,this.group,this.stage,this.dropdownValue, {super.key});
//
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends State<ProfileView> {
//   static late pw.Font arFont;
//
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
//   ScreenshotController screenshotController = ScreenshotController();
//   int _counter = 0;
//   late Uint8List _imageFile;
//   Uint8List? bytes;
//   final GlobalKey globalKey = GlobalKey();
//   late int attendanceNumber;
//
//
//   late int absentNumber;
//
//   final gradientList = <List<Color>>[
//     [
//       Colors.green,
//       Colors.green,
//     ],
//     [
//       Colors.red,
//       Colors.red,
//     ],
//     [
//       Colors.blue,
//       Colors.blue,
//     ],
//   ];
//
//   int getattendancenum(List<Attendance>? attend) {
//     int attendNum = 0;
//     for (int i = 0; i < attend!.length; i++) {
//       if (attend[i].isAttend == true) {
//         ++attendNum;
//       }
//     }
//     return attendNum;
//   }
//   late Map<String, double> worksData;
//   @override
//   Widget build(BuildContext context) {
//     attendanceNumber = getattendancenum(widget.student.studentAttendances);
//     absentNumber = widget.student.studentAttendances!.length - attendanceNumber;
//      if(widget.dropdownValue == 'Maths'){
//      worksData = {
//          "Quizzes": widget.student.totalCompleteQuiz!.toDouble(),
//          "HomeWork": widget.student.totalCompleteHw!.toDouble(),
//          "Exams": widget.student.totalCompleteExam!.toDouble(),
//        };
//      }
//      else{
//        worksData = {
//          "Apply Quizzes": widget.student.totalCompleteApplyQuiz!.toDouble(),
//          "Apply HomeWork": widget.student.totalCompleteApplyHw!.toDouble(),
//          "Apply Exams": widget.student.totalCompleteApplyExam!.toDouble(),
//        };
//      }
//     Map<String, double> attendanceData = {
//       "Attend": attendanceNumber.toDouble(),
//       "Absent": absentNumber.toDouble(),
//     };
//
//
//     return Container(
//       color: primaryColorDark,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Screenshot(
//               controller: screenshotController,
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   gradient: const LinearGradient(
//                     colors: [Colors.purple, Colors.blue],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [Colors.blue, Colors.purple],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       ),
//                       child: QrImageView(
//                         data: '${widget.student.studentCompleteId}',
//                         version: QrVersions.auto,
//                         dataModuleStyle: QrDataModuleStyle(
//                             color: Theme
//                                 .of(context)
//                                 .colorScheme
//                                 .primary),
//                         constrainErrorBounds: true,
//                         eyeStyle: QrEyeStyle(
//                             color: Theme
//                                 .of(context)
//                                 .colorScheme
//                                 .primary,
//                             eyeShape: QrEyeShape.square),
//                         backgroundColor: Colors.white,
//                         padding: const EdgeInsets.all(6),
//                         errorCorrectionLevel: 1,
//                         foregroundColor: Colors.black,
//                         errorStateBuilder: (context, error) =>
//                             const Text('errorsssss'),
//                         semanticsLabel: '${widget.student.studentName}',
//                         size: 200,
//                         gapless: true,
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.only(left: 4,top: 8,bottom: 8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                             child: Text(
//                               '${widget.student.studentCompleteId} ${widget.student.studentName}',
//                               style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   overflow: TextOverflow.ellipsis,
//                                   color: Colors.white),
//                               maxLines: 1,
//                             ),
//                           ),
//                           const SizedBox(height: 8,),
//                           Text(
//                             '${widget.stage.title} - ${widget.group.title}',
//                             style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 overflow: TextOverflow.ellipsis,
//                                 color: Colors.white),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 gradient: const LinearGradient(
//                   colors: [Colors.purple, Colors.blue],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: IconButton(
//                   onPressed: () {
//                     convertWidgetToImage();
//
//                     // displayPdfForDegrees();
//                   },
//                   icon: const Icon(
//                     Icons.share,
//                     color: Colors.white,
//                     size: 24,
//                   )),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: (){
//                 Navigator.pushNamed(context, StudentWorksView.routeName,arguments: widget.student);
//               },
//               child: PieChart(
//                 dataMap: worksData,
//                 animationDuration: const Duration(milliseconds: 2000),
//                 chartLegendSpacing: 20,
//                 chartRadius: MediaQuery
//                     .of(context)
//                     .size
//                     .width / 2.5,
//                 gradientList: gradientList,
//                 emptyColorGradient: const [
//                   Color(0xff6c5ce7),
//                   Colors.blue,
//                 ],
//                 initialAngleInDegree: 0,
//                 chartType: ChartType.ring,
//                 ringStrokeWidth: 8,
//                 centerText: "Works",
//                 centerTextStyle: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16),
//                 legendOptions: const LegendOptions(
//                   showLegendsInRow: false,
//                   legendPosition: LegendPosition.right,
//                   showLegends: true,
//                   legendShape: BoxShape.circle,
//                   legendTextStyle:
//                   TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 chartValuesOptions: const ChartValuesOptions(
//                   chartValueStyle: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                   chartValueBackgroundColor: Colors.transparent,
//                   showChartValueBackground: true,
//                   showChartValues: true,
//                   showChartValuesInPercentage: false,
//                   showChartValuesOutside: false,
//                   decimalPlaces: 0,
//                 ),
//                 // gradientList: ---To add gradient colors---
//                 // emptyColorGradient: ---Empty Color gradient---
//               ),
//             ),
//             const Divider(
//               thickness: 1,
//               color: Colors.white,
//             ),
//             InkWell(
//               onTap: (){
//                 Navigator.pushNamed(context, StudentAttendancesView.routeName,arguments: widget.student);
//               },
//               child: PieChart(
//                 dataMap: attendanceData,
//                 animationDuration: const Duration(milliseconds: 1500),
//                 chartLegendSpacing: 60,
//                 chartRadius: MediaQuery
//                     .of(context)
//                     .size
//                     .width / 2.5,
//                 gradientList: gradientList,
//                 emptyColorGradient: const [
//                   Color(0xff6c5ce7),
//                   Colors.blue,
//                 ],
//                 initialAngleInDegree: 0,
//                 chartType: ChartType.ring,
//                 ringStrokeWidth: 8,
//                 centerText: "Attendance",
//                 centerTextStyle: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14),
//                 legendOptions: const LegendOptions(
//                   showLegendsInRow: false,
//                   legendPosition: LegendPosition.right,
//                   showLegends: true,
//                   legendShape: BoxShape.circle,
//                   legendTextStyle:
//                   TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 chartValuesOptions: const ChartValuesOptions(
//                   chartValueStyle: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold),
//                   chartValueBackgroundColor: Colors.transparent,
//                   showChartValueBackground: true,
//                   showChartValues: true,
//                   showChartValuesInPercentage: false,
//                   showChartValuesOutside: false,
//                   decimalPlaces: 0,
//                 ),
//                 // gradientList: ---To add gradient colors---
//                 // emptyColorGradient: ---Empty Color gradient---
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   void convertWidgetToImage() async {
//     await screenshotController.capture(delay: const Duration(milliseconds: 10))
//         .then((Uint8List? image) async {
//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/image.png').create();
//         await imagePath.writeAsBytes(image);
//         /// Share Plugin
//         await Share.shareFiles([imagePath.path],text: '');
//
//       }
//     });
//   }
//
//   saveImg(File image) async {
//     final result = await ImageGallerySaver.saveImage(image.readAsBytesSync());
//     print("File Saved to Gallery");
//   }
//
//
//
//
// void displayPdfForDegrees() {
//   final pdf = pw.Document();
//   pdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       build: (context) {
//         return [
//         pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.center,
//           children: [
//             pw.Text(
//               'Dr / MOHAMED GAMAL',
//               textAlign: pw.TextAlign.center,
//               style: pw.TextStyle(
//                 fontSize: 16,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.SizedBox(height: 10),
//             pw.Text(
//               'Student : ${widget.student.studentCompleteId} ${widget.student.studentName}',
//               style: pw.TextStyle(
//
//                 fontSize: 20,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//               textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${widget.student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
//             ),
//             pw.SizedBox(height: 10),
//             pw.Table.fromTextArray(
//               headerStyle: pw.TextStyle(
//                 fontSize: 16,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//               cellAlignment: pw.Alignment.center,
//               data: [
//                 ['Date', 'Type', 'Degree', 'Sent'],
//                 ...widget.student.studentDegrees!.map((degree) => [
//                   degree.dateDegree,
//                   degree.typeDegree,
//                   degree.degree,
//                   degree.isSend! ?'YES':'NO',
//                 ])
//               ],
//             ),
//           ],
//         )
//         ];
//       },
//     ),
//   );
//
//
//   /// open Preview Screen
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PreviewScreen(
//         doc: pdf,
//         groupName: "${widget.group.title}",
//         stageName: "${widget.stage.title}",
//       ),
//     ),
//   );
// }
//
// }