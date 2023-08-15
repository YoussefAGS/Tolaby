// import 'package:assistant/database_utils/group_database.dart';
// import 'package:assistant/database_utils/stage_database.dart';
// import 'package:assistant/database_utils/student_database.dart';
// import 'package:assistant/models/group_model.dart';
// import 'package:assistant/models/stage_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../../../models/student_model.dart';
//
//
// class UpdateDegreeBottomSheet extends StatefulWidget {
//   Student student;
//   int index;
//   Group group;
//   Stage stage;
//   UpdateDegreeBottomSheet(this.student,this.index,this.group,this.stage, {super.key});
//
//   @override
//   State<UpdateDegreeBottomSheet> createState() => _UpdateDegreeBottomSheetState();
// }
//
// class _UpdateDegreeBottomSheetState extends State<UpdateDegreeBottomSheet> {
//   String dropdownValue = 'Quiz';
//
//   List <String> spinnerItems = [
//     'Quiz',
//     'H.w',
//     'Exam',
//   ] ;
//   GlobalKey<FormState> mykey = GlobalKey<FormState>();
// bool isArabic = false;
// late TextEditingController deg ;
//   @override
//   Widget build(BuildContext context) {
//     deg = TextEditingController(text: '${widget.student.studentDegrees![widget.index].degree}');
//
//
//     return  Form(
//       key: mykey,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.fromLTRB(2, 35, 2, 2),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Center(
//                 child: Text(
//                   'Update Mark',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).colorScheme.primary,
//                     fontSize: 21,
//                   ),
//                 )),
//             Divider(
//               color: Theme.of(context).colorScheme.primary,
//               thickness: 2,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             TextFormField(
//               controller: deg,
//               textDirection: TextDirection.ltr,
//
//               onChanged: (text){
//                 widget.student.studentDegrees![widget.index].degree = text;
//
//               },
//               keyboardType: TextInputType.phone,
//
//               decoration: InputDecoration(
//                   labelText: 'Enter Mark',
//                   labelStyle:  const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
//                     fontSize: 16,fontWeight: FontWeight.normal,),
//                   hintStyle: const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
//                       fontSize: 16,fontWeight: FontWeight.normal),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Theme.of(context).colorScheme.primary,),
//                   )
//               ),
//               validator: (text){
//                 if(text == null || text.trim().isEmpty){
//                   return 'Please Enter Degree';
//                 }
//               },
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//
//             DropdownButton<String>(
//               value: dropdownValue,
//               icon: const Icon(Icons.arrow_drop_down),
//               iconSize: 32,
//               iconEnabledColor: Theme.of(context).colorScheme.primary,
//               isExpanded: true,
//               focusColor: Colors.white,
//               elevation: 16,
//               style: TextStyle(
//                  color: Theme.of(context).colorScheme.primary,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//
//               onChanged: (txt) {
//                 setState(() {
//                   widget.student.studentDegrees![widget.index].typeDegree = txt!;
//                   dropdownValue = txt;
//
//                 });
//               },
//               items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//
//             ListTile(
//               leading: Icon(Icons.today,color: Theme.of(context).colorScheme.primary,),
//               title: const Text('Mark Date',
//                 style: TextStyle(
//                     fontSize: 16
//                 ),),
//               subtitle: Text('${widget.student.studentDegrees![widget.index].dateDegree}',
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.primary,
//                 ),),
//               trailing:  Icon(Icons.arrow_drop_down,color: Theme.of(context).colorScheme.primary,),
//             ),
//
//             const SizedBox(
//               height: 16,
//             ),
//
//             ElevatedButton(
//               style: ButtonStyle(
//                 padding: const MaterialStatePropertyAll(EdgeInsets.all(8)),
//                 backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
//               ),
//               onPressed: () {
//                 validate();
//                 setState(() {
//
//                 });
//
//               },
//               child: const Text(
//                 'Save ',
//                 style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void validate(){
//     if (mykey.currentState!.validate()) {
//       StudentDatabase.updateStudentInFirebase(widget.student);
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
//       ///--------------------------------------------------------------
//       for(int i=0;i<widget.stage.totalStudentsOfStage!.length;i++){
//         if(widget.stage.totalStudentsOfStage![i].studentDataBaseID==widget.student.studentDataBaseID){
//           widget.stage.totalStudentsOfStage![i]=widget.student;
//           break;
//         }
//       }
//       StageDatabase.updateStagesInFirebase(widget.stage);
// ///---------------------------------------------------------
//       Navigator.pop(context);
//     }
//   }
//
//
// }
