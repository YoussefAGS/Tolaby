
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:tolaby/modles/group_model.dart';
import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/screens/group/update_group.dart';
import 'package:tolaby/screens/stage/widgets/ScreenLockComponent.dart';
import 'package:tolaby/services/Groups.dart';

class GroupItem extends StatefulWidget {
  Group group;
  Stage stage;

  GroupItem(this.group, this.stage, {super.key});

  @override
  State<GroupItem> createState() => _GroupItemState();
}

class _GroupItemState extends State<GroupItem> {
  static late pw.Font arFont;

  init() async {
    arFont = pw.Font.ttf(
        await rootBundle.load('assets/fonts/Cairo/static/Cairo-Bold.ttf'));
  }

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            onPressed: (context) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return  ScreenLockComponent((){
                    GroupServices.deleatGroup(id: widget.group.id);
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
            width: 4,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            onPressed: (context) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return  ScreenLockComponent((){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, UpdateGroup.routeName,
                        arguments: StageAndGroup(widget.group,widget.stage));
                  });
                },
              );
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          const SizedBox(
            width: 4,
          ),
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            onPressed: (context) {
              // displayPdf();
            },
            backgroundColor: Colors.yellow.shade700,
            foregroundColor: Colors.white,
            icon: Icons.print,
          ),
        ]),
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, StudentWidget.routeName,
            //     arguments: StageAndGroup(widget.group, widget.stage));
          },
          child:Container(
            margin: const EdgeInsets.only(bottom: 16,right: 4,left: 4),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white,width: 3),
              gradient: const LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 21,
                  child: Text(
                    "${widget.group.groupRank}",
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "${widget.group.title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Code: ${widget.group.groupStartStudentCode} ",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  "${widget.group.place}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                trailing:  Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text("${widget.group.groupTotalStudents}",style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple
                  ),),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void displayPdf() {
  //   final pdf = pw.Document();
  //
  //   // Constants for page layout
  //    int studentsPerPage = 9; // Number of students per page
  //    int studentsPerRow = 3; // Number of students per row
  //    int maxStudents = 800; // Maximum number of students across all pages
  //
  //   // Calculate the number of pages needed based on the number of students
  //   int totalPages = (widget.group.groupStudents!.length / studentsPerPage).ceil();
  //   if (totalPages > (maxStudents / studentsPerPage).ceil()) {
  //     // Limit the total number of pages to `maxStudents / studentsPerPage`
  //     totalPages = (maxStudents / studentsPerPage).ceil();
  //   }
  //
  //   // Generate pages dynamically based on the number of students
  //   for (int page = 0; page < totalPages; page++) {
  //     pdf.addPage(
  //       pw.MultiPage(
  //         textDirection: pw.TextDirection.rtl,
  //         theme: pw.ThemeData.withFont(base: arFont),
  //         pageFormat: PdfPageFormat.a4,
  //         build: (context) {
  //           List<pw.TableRow> currentPageData = List.generate(
  //             (studentsPerPage / studentsPerRow).ceil(),
  //                 (rowIndex) {
  //               int startIndex = page * studentsPerPage + rowIndex * studentsPerRow;
  //               int endIndex = startIndex + studentsPerRow;
  //               if (startIndex >= widget.group.groupStudents!.length) {
  //                 // Return an empty row if no more students
  //                 return  pw.TableRow(children: []);
  //               }
  //               if (endIndex > widget.group.groupStudents!.length) {
  //                 endIndex = widget.group.groupStudents!.length;
  //               }
  //
  //               List<pw.Widget> rowChildren = [];
  //               for (int i = startIndex; i < endIndex; i++) {
  //                 // Student student = widget.group.groupStudents![i];
  //                 rowChildren.add(
  //                  pw.Container(
  //                    margin:  pw.EdgeInsets.all(12),
  //                    padding:  pw.EdgeInsets.all(4),
  //                    // color: PdfColors.blue400,
  //                    child:  pw.Column(
  //                      children: [
  //                        pw.SizedBox(height: 16),
  //                        pw.Row(
  //                            mainAxisAlignment: pw.MainAxisAlignment.center,
  //                            children: [
  //                              pw.Text(
  //                                  '${widget.group.groupStartStudentCode}',
  //                                  style:  pw.TextStyle(
  //                                    fontSize: 16,
  //                                  ),
  //                                  textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${widget.group.groupStartStudentCode}')?pw.TextDirection.rtl:pw.TextDirection.ltr
  //                              ),
  //                              pw.Text(
  //                                '${student.studentId}',
  //                                style:  pw.TextStyle(
  //                                  fontSize: 16,
  //                                ),
  //                                textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentId!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
  //
  //                              ),
  //                            ]
  //                        ),
  //
  //                        pw.BarcodeWidget(
  //                          color: PdfColors.black,
  //                          barcode: pw.Barcode.qrCode(),
  //                          data: '${student.studentCompleteId}',
  //                          height: 90,
  //                          width: 550,
  //                        ),
  //                        pw.Text(
  //                          ' ${student.studentName!} ',
  //                          style:  pw.TextStyle(
  //                            fontSize: 13,
  //                          ),
  //                          textDirection: RegExp(r'[\u0600-\u06FF]').hasMatch('${student.studentName!}')?pw.TextDirection.rtl:pw.TextDirection.ltr,
  //                          maxLines: 1,
  //                          textAlign: pw.TextAlign.center
  //                        ),
  //                        pw.SizedBox(height: 32),
  //                      ],
  //                    ),
  //                  ),
  //                 );
  //               }
  //
  //               return pw.TableRow(
  //                 children: rowChildren.map((child) => pw.Container(child: child)).toList(),
  //               );
  //             },
  //           );
  //
  //           return [
  //             pw.Table(
  //               children: [
  //                  pw.TableRow(
  //                   children: [
  //
  //                   ],
  //                 ),
  //                 ...currentPageData,
  //               ],
  //             ),
  //           ];
  //         },
  //       ),
  //     );
  //   }
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
}

class StageAndGroup {
  Stage currentStage;
  Group currentGroup;

  StageAndGroup(this.currentGroup, this.currentStage);
}
