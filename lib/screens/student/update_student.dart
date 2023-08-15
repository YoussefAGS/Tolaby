
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiselect/multiselect.dart';
import 'package:tolaby/screens/student/student_item.dart';

import '../../utiles/constant.dart';




class UpdateStudent extends StatefulWidget {
  static const String routeName = 'Update Student';

  const UpdateStudent({super.key});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TextEditingController  studentNameController ;
  late TextEditingController  studentNumberController ;
  late TextEditingController  studentParentNumberController;
  late TextEditingController  studentCodeController ;
  late AllStudentAndGroup studentGroupStage;
  DateTime selectedDate = DateTime.now();
  List<dynamic> subjects = ['Maths','Apply'];
  List<dynamic> selectedSubjects = [];
  StreamSubscription? connection;
  bool isoffline = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.ethernet) {
        //connection is from wired connection
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.bluetooth) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.other) {
        //connection is from bluetooth threatening
        setState(() {
          isoffline = true;
        });
      }
    });

  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    studentGroupStage = ModalRoute.of(context)!.settings.arguments as AllStudentAndGroup;
    studentNameController = TextEditingController(text: studentGroupStage.st.studentName);
    studentNumberController = TextEditingController(text: studentGroupStage.st.studentPhoneNumber);
    studentParentNumberController = TextEditingController(text: studentGroupStage.st.studentParentPhoneNumber);
    selectedSubjects = studentGroupStage.st.studentSubjects!;
    // isoffline == true?const ConnectionNetworkComponent():
    return Scaffold(
      backgroundColor: primaryColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.white,
            size: 32
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text('Update Student',style: TextStyle(
          color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Card(
            elevation: 33,
            margin: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Icon(Icons.person,size: 70,color: Theme.of(context).colorScheme.primary,)),

                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),


                  TextFormField(
                    textDirection:TextDirection.ltr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
                    ],
                    onChanged: (text){
                      studentGroupStage.st.studentName = text;

                    },

                    validator: (text){
                      if(text!.trim() == ''){
                        return "Enter Student Name ";
                      }
                      return null;
                    },
                    controller: studentNameController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter Student Name',
                      hintStyle: const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                      focusColor: Colors.cyan,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: 'Student Name',
                      labelStyle:  const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    onChanged: (text){
                      studentGroupStage.st.studentPhoneNumber = text;

                    },

                    validator: (text){
                      if(text!.trim() == ''){
                        return "Enter Student Number ";
                      }
                      return null;
                    },
                    controller: studentNumberController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter Student Number',
                      hintStyle: const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                      focusColor: Colors.cyan,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: 'Student Number',
                      labelStyle:  const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                    ),
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),

                  TextFormField(
                    textDirection:TextDirection.ltr,

                    onChanged: (text){
                      studentGroupStage.st.studentParentPhoneNumber = text;
                    },

                    validator: (text){
                      if(text!.trim() == ''){
                        return "Enter Parent Number ";
                      }
                      return null;
                    },
                    controller: studentParentNumberController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter Parent Number',
                      hintStyle: const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                      focusColor: Colors.cyan,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: 'Parent Number',
                      labelStyle:  const TextStyle(color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,fontWeight: FontWeight.normal),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  InkWell(
                    onTap: (){
                      showmydatepicker();
                    },
                    child: ListTile(
                      leading:  Icon(Icons.today,color: Theme.of(context).colorScheme.primary),
                      title:  const Text('Start Date'),
                      subtitle:  Text('${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                      ),),
                      trailing:  Icon(Icons.arrow_drop_down,color: Theme.of(context).colorScheme.primary),
                    ),
                  ),

                  DropDownMultiSelect(
                    icon: const Icon(Icons.add_circle_outline,color: Colors.blue,),
                    options: subjects,
                    selectedValues: selectedSubjects,
                    onChanged: (value) {
                      setState(() {
                        selectedSubjects = value;
                      });

                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(70, 10, 70, 10))
                    ),
                    onPressed: (){
                      if(selectedSubjects.isEmpty){
                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: const Text('Alert!',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),),
                          content: const Text("Should Select Subjects First ",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),),
                          actions: [
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const Text('OK'))
                          ],
                        ),);

                      }else{
                        ValidateForm();
                        Navigator.pop(context);
                        setState(() {

                        });
                      }

                    },
                    child: const Text('Save',style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showmydatepicker() async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: selectedDate.add(const Duration(days: 365)),
    )?? DateTime.now();
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }


  void ValidateForm() async {
    if (formkey.currentState!.validate()) {
      for(int i =0;i<studentGroupStage.st.studentSubjects!.length;i++){
        if(studentGroupStage.st.studentSubjects![i]=='Maths'){
          studentGroupStage.gr.groupTotalMathsStudents = studentGroupStage.gr.groupTotalMathsStudents! -1;
        }else{
          studentGroupStage.gr.groupTotalApplyStudents =  studentGroupStage.gr.groupTotalApplyStudents! -1;
        }
      }
      studentGroupStage.st.studentSubjects = selectedSubjects;
      for(int i =0;i<selectedSubjects.length;i++){
        if(selectedSubjects[i]=='Maths'){
          studentGroupStage.gr.groupTotalMathsStudents =  studentGroupStage.gr.groupTotalMathsStudents! +1;
        }else{
          studentGroupStage.gr.groupTotalApplyStudents = studentGroupStage.gr.groupTotalApplyStudents! +1;
        }
      }
      // StudentDatabase.updateStudentInFirebase(studentGroupStage.st);
      ///-------------------------------------------------------------------

      for(int i=0;i<studentGroupStage.gr.groupStudents!.length;i++){
        if(studentGroupStage.gr.groupStudents![i].studentDataBaseID==studentGroupStage.st.studentDataBaseID){
          studentGroupStage.gr.groupStudents![i]= studentGroupStage.st;
          break;
        }
      }
      // GroupDatabase.updateGroupInFirebase(studentGroupStage.gr);
      ///-------------------------------------------------------------------
      for(int i=0;i<studentGroupStage.sta.totalStudentsOfStage!.length;i++){
        if(studentGroupStage.sta.totalStudentsOfStage![i].studentDataBaseID==studentGroupStage.st.studentDataBaseID){
          studentGroupStage.sta.totalStudentsOfStage![i]= studentGroupStage.st;
          break;
        }
      }
      // StageDatabase.updateStagesInFirebase(studentGroupStage.sta);
      ///-------------------------------------------------------------------




    }
  }

}
