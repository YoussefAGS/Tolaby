import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:tolaby/screens/student/widgets/TextFormFieldComponent.dart';
import 'package:tolaby/services/Sudent.dart';
import 'package:tolaby/utiles/constant.dart';

import '../../../../base.dart';
import '../../../modles/student_model.dart';
import '../student_widget.dart';
import 'add_student_navigator.dart';
import 'add_student_view_model.dart';

class AddStudent extends StatefulWidget {
  static const String routeName = 'Add New Student';

  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends BaseView<AddStudent,AddStudentViewModel>
    implements AddStudentNavigator {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var studentNameController = TextEditingController();

  var studentNumberController = TextEditingController();

  var studentParentNumberController = TextEditingController();

  List<String> subjects = ['Maths', 'Apply',];
  List<String> selectedSubjects = [];


  late AllStageAndGroup stageGroup;
  DateTime selectedDate = DateTime.now();

  StreamSubscription? connection;
  bool isoffline = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
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
  initViewModel() {
    // TODO: implement initViewModel
    return AddStudentViewModel();
  }
  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    stageGroup = ModalRoute.of(context)!.settings.arguments as AllStageAndGroup;

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
        title: const Text('Add New Student', style: TextStyle(
          color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold,
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
                      child: Icon(Icons.person_add, size: 70, color: Theme
                          .of(context)
                          .colorScheme
                          .primary,)),

                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01,),

                  TextFormFieldComponent(
                    validate: (text) {
                      if (text!.trim() == '') {
                        return "Enter Student Name";
                      }
                      return null;
                    },
                    controller: studentNameController,
                    typeKeyboard: TextInputType.text,
                    action: TextInputAction.next,
                    hint: "Enter Student Name",
                    labl: 'Name',
                  ),

                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),

                  TextFormFieldComponent(
                    validate: (text) {
                      if (text!.trim() == '') {
                        return "Enter Student Number";
                      }
                      return null;
                    },
                    controller: studentNumberController,
                    typeKeyboard: TextInputType.phone,
                    action: TextInputAction.next,
                    hint: 'Enter Student Number',
                    labl: 'Student Number',
                  ),

                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),

                  TextFormFieldComponent(
                    validate: (text) {
                      if (text!.trim() == '') {
                        return "Enter Parent Number";
                      }
                      return null;
                    },
                    controller: studentParentNumberController,
                    typeKeyboard: TextInputType.phone,
                    action: TextInputAction.next,
                    hint: "Enter Parent Number",
                    labl: 'Parent Number',
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03,),
                  DropDownMultiSelect(
                    options: subjects,
                    selectedValues: selectedSubjects,
                    onChanged: (value) {
                      setState(() {
                        selectedSubjects = value;
                      });
                    },
                    whenEmpty: 'Select Subject',
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02,),
                  InkWell(
                    onTap: () {
                      showmydatepicker();
                    },
                    child: ListTile(
                      leading: Icon(Icons.today, color: Theme
                          .of(context)
                          .colorScheme
                          .primary),
                      title: const Text('Start Date'),
                      subtitle: Text('${selectedDate.day} / ${selectedDate
                          .month} / ${selectedDate.year}', style: TextStyle(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary
                      ),),
                      trailing: Icon(Icons.arrow_drop_down, color: Theme
                          .of(context)
                          .colorScheme
                          .primary),
                    ),
                  ),

                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.06,),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        padding: const MaterialStatePropertyAll(EdgeInsets
                            .fromLTRB(70, 10, 70, 10))
                    ),
                    onPressed: () {
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
                        validateAddStudentForm();
                      }
                    },
                    child: const Text('Save', style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showmydatepicker() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: selectedDate.add(const Duration(days: 365)),
    ) ?? DateTime.now();
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  void validateAddStudentForm() async {
    if (formkey.currentState!.validate()) {
      // Random random = Random();

      String studentCode = "${stageGroup.newstage.stageStudentsRank}";
      // String studentCode = "${random.nextInt(10) + 80}";
      // while (true) {
      //   Student? temp = await UserStudentDatabase.readOnlyStudentFromFireBase(studentCode);
      //   if (temp?.studentId != studentCode) {
      //     break;
      //   }
      //   else {
      //     studentCode = "${random.nextInt(10) + 80}";
      //   }
      // }
      Student student = Student(
          studentCompleteId: "${stageGroup.newgroup.groupStartStudentCode}$studentCode",
          startStudentCode: stageGroup.newgroup.groupStartStudentCode,
          studentId: studentCode,
          studentName: studentNameController.text,
          studentEmail: '${stageGroup.newgroup.groupStartStudentCode}$studentCode@gmail.com',
          studentPhoneNumber: studentNumberController.text,
          studentParentPhoneNumber: studentParentNumberController.text,
          studentAddress: 'Egypt',
          studentImageUrl: '',
          totalCompleteQuiz: 0,
          totalCompleteHw: 0,
          totalCompleteExam: 0,
          totalAttendanceLessons: 0,
          groupIdOfStudent: stageGroup.newgroup.id,
          groupNameOfStudent: stageGroup.newgroup.title,
          stageIdOfStudent: stageGroup.newstage.id,
          studentStartDate: '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
          stageNameOfStudent: stageGroup.newstage.title,
          groupStartCodeOfStudent: stageGroup.newgroup.groupStartStudentCode,
          teacherId: stageGroup.newstage.teacherId,
          studentSubjects: selectedSubjects,
          studentAttendances: [],
          isSend: true
      );
      // StudentDatabase.addStudentToFireBase(student);
      // for(int i =0;i<selectedSubjects.length;i++){
      //   if(selectedSubjects[i]=='Maths'){
      //     stageGroup.newgroup.groupTotalMathsStudents = stageGroup.newgroup.groupTotalMathsStudents! +1;
      //     ++stageGroup.newstage.totalStudentsOfStageNumber;
      //   }else{
      //     stageGroup.newgroup.groupTotalApplyStudents = stageGroup.newgroup.groupTotalApplyStudents! +1;
      //     ++stageGroup.newstage.totalStudentsOfApplyStageNumber;
      //   }
      // }
      // stageGroup.newgroup.groupTotalStudents = stageGroup.newgroup.groupTotalStudents! +1;
      // stageGroup.newgroup.groupStudents!.add(student);
      // GroupDatabase.updateGroupInFirebase(stageGroup.newgroup);
      // stageGroup.newstage.totalStudentsOfStage!.add(student);
      // ++stageGroup.newstage.stageStudentsRank;
      // StageDatabase.updateStagesInFirebase(stageGroup.newstage);
      StudentServices.addStudent(student: student);
      Navigator.pop(context);
    }


  }






}
