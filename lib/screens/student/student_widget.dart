import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tolaby/screens/student/student%20subject/apply_widget.dart';
import 'package:tolaby/screens/student/student%20subject/math_widget.dart';
import 'package:tolaby/screens/student/student_item.dart';
import 'package:tolaby/screens/student/widgets/search.dart';
import 'package:tolaby/utiles/constant.dart';
import '../../modles/group_model.dart';
import '../../modles/stage_model.dart';
import '../../modles/student_model.dart';
import '../group/group_item.dart';
import 'add_student/add_student_view.dart';

class StudentWidget extends StatefulWidget {
  static const String routeName = 'Student Widget';

  const StudentWidget({super.key});

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  late StageAndGroup stageAndGroup;
  // late MyProvider provider;

  String dropdownValue = 'Maths';
  List<String> spinnerItems = [
    'Maths',
    'Apply',
  ];
  late Stream<List<Student>> allStusent ;
  List<Student> allSTUD = [];
  int studentsMath =0;
  int studentsApply=0;
  int numofstudents=0;
  StreamSubscription? connection;
  bool isoffline = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // connection = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   // whenevery connection status is changed.
    //   if (result == ConnectivityResult.none) {
    //     //there is no any connection
    //     setState(() {
    //       isoffline = true;
    //     });
    //   } else if (result == ConnectivityResult.mobile) {
    //     //connection is mobile data network
    //     setState(() {
    //       isoffline = false;
    //     });
    //   } else if (result == ConnectivityResult.wifi) {
    //     //connection is from wifi
    //     setState(() {
    //       isoffline = false;
    //     });
    //   } else if (result == ConnectivityResult.ethernet) {
    //     //connection is from wired connection
    //     setState(() {
    //       isoffline = false;
    //     });
    //   } else if (result == ConnectivityResult.bluetooth) {
    //     //connection is from bluetooth threatening
    //     setState(() {
    //       isoffline = false;
    //     });
    //   } else if (result == ConnectivityResult.other) {
    //     //connection is from bluetooth threatening
    //     setState(() {
    //       isoffline = true;
    //     });
    //   }
    // });


}
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 100));
    // if failed,use refreshFailed()
    // fetchAndStoreStudents();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    await Future.delayed(const Duration(milliseconds: 100));

    if(mounted) {
      setState(() {
        // fetchAndStoreStudents();
      });
    }
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // provider = Provider.of(context);
    stageAndGroup = ModalRoute.of(context)!.settings.arguments as StageAndGroup;
    if(allSTUD.isEmpty){
      if(mounted){
        // fetchAndStoreStudents();
      }
    }
    // isoffline == true?const ConnectionNetworkComponent():
    return Scaffold(
      backgroundColor: primaryColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          '${stageAndGroup.currentStage.title} ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 24,
            ),
            tooltip: 'Search Student',
            onPressed: () => showSearch(
              context: context,
              delegate: SearchPage(
                barTheme: ThemeData.light(),
                searchStyle: const TextStyle(color: Colors.white),
                onQueryUpdate: print,
                items: stageAndGroup.currentStage.totalStudentsOfStage!,
                searchLabel: 'Search Student',
                suggestion: const Center(
                  child: Text('Student Not Found :('),
                ),
                failure: const Center(
                  child: Text('Student Not Found :('),
                ),
                filter: (student) => [
                  student.studentName,
                  student.studentId,
                  student.studentCompleteId,
                  student.studentPhoneNumber,
                  student.studentParentPhoneNumber,
                ],
                builder: (student) => StudentItem(student, stageAndGroup.currentGroup,stageAndGroup.currentStage,dropdownValue),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(
                Icons.archive,
                size: 24,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, Archive.routeName, arguments: AllStageAndGroup(stageAndGroup.currentStage,stageAndGroup.currentGroup));
              }),
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(
                //     context, MessageWidget.routeName,
                //     arguments: stageAndGroup);
              },
              icon: const Icon(
                Icons.message,
                color: Colors.white,
                size: 24,
              )),
        ],
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35,),
            side: const BorderSide(color: Colors.blue,width: 2)
        ),
        splashColor: Colors.deepPurple.shade900,
        elevation: 2,
        backgroundColor:Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, AddStudent.routeName,
              arguments: AllStageAndGroup(stageAndGroup.currentStage,stageAndGroup.currentGroup));
        },
        child:  const Icon(Icons.add, size: 28,color: Colors.blue,),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(waterDropColor: Colors.purple,
            refresh: CircularProgressIndicator(color: Colors.purple,),
            complete: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Done',style: TextStyle(color: Colors.white),),
                SizedBox(width: 4,),
                Icon(Icons.done,color: Colors.green,),
              ],
            )),
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: DefaultTabController(
          length: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.05,
                width: MediaQuery.of(context).size.width*0.95,
                padding: const EdgeInsets.only(left: 8,),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,width: 1),
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Total : ${numofstudents}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Maths : ${studentsMath} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,

                        ),
                      ),
                    ),
                    studentsApply == 0?
                    const SizedBox(height: 0,):Expanded(
                      child: Text(
                        'Apply : ${studentsApply}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,

                        ),
                      ),
                    ),

                    Expanded(child: IconButton(
                      icon: Icon(Icons.refresh,color: Colors.white,size: 24,),onPressed: (){
                      // fetchAndStoreStudents();
                    },
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 1),
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Colors.purple, Colors.blue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(child: Text('${stageAndGroup.currentGroup.title}',style: TextStyle(color: Colors.white,fontSize: 13,fontWeight: FontWeight.bold),)))),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.only(right: 16,left: 16),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        dropdownColor: primaryColorDark,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 26,
                        iconEnabledColor: Colors.white,
                        isExpanded: true,
                        focusColor:primaryColorDark,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (txt) {
                          setState(() {
                            dropdownValue = txt!;
                          });
                        },
                        items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(right: 2,left: 2),
                child: TabBar(
                  indicatorColor: Colors.lightBlue,
                  indicatorWeight: 1,
                  tabs: [
                    Tab(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Center(child: Text('Quiz : ${dropdownValue == 'Maths'?stageAndGroup.currentGroup.groupMaxQuizzes : stageAndGroup.currentGroup.groupMaxApplyQuizzes } - H.W : ${ dropdownValue == 'Maths'? stageAndGroup.currentGroup.groupMaxHw : stageAndGroup.currentGroup.groupMaxApplyHw} - Exam : ${dropdownValue == 'Maths'? stageAndGroup.currentGroup.groupMaxExams : stageAndGroup.currentGroup.groupMaxApplyExams}',style: const TextStyle(color: Colors.white,fontSize: 13,),))),
                        dropdownValue == 'Maths'?
                        PopupMenuButton(
                            icon: const Icon(Icons.add,color: Colors.white,size: 24,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    stageAndGroup.currentGroup.groupMaxQuizzes=stageAndGroup.currentGroup.groupMaxQuizzes!+1;
                                    // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                    updateGroupWorks();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text('New Quiz Added Successfully',style: TextStyle(color: Colors.orange),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });


                                  },
                                  child: const Text('Add New Quiz'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    stageAndGroup.currentGroup.groupMaxHw = stageAndGroup.currentGroup.groupMaxHw!+1;
                                    // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                    updateGroupWorks();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text('New H.W Added Successfully',style: TextStyle(color: Colors.orange),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text('Add New H.W'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    stageAndGroup.currentGroup.groupMaxExams=stageAndGroup.currentGroup.groupMaxExams!+1;
                                    // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);

                                    updateGroupWorks();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text('New Exam Added Successfully',style: TextStyle(color: Colors.orange),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text('Add New Exam'))),

                            ])
                            : PopupMenuButton(
                            icon: const Icon(Icons.add,color: Colors.white,size: 24,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    stageAndGroup.currentGroup.groupMaxApplyQuizzes =  stageAndGroup.currentGroup.groupMaxApplyQuizzes!+1;
                                    // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);

                                    updateGroupWorks();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text('New Apply Quiz Added Successfully',style: TextStyle(color: Colors.orange),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });


                                  },
                                  child: const Text('Add New Apply Quiz'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    stageAndGroup.currentGroup.groupMaxApplyHw = stageAndGroup.currentGroup.groupMaxApplyHw!+1;
                                    // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                    updateGroupWorks();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text('New Apply H.W Added Successfully',style: TextStyle(color: Colors.orange),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text('Add New Apply H.W'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    stageAndGroup.currentGroup.groupMaxApplyExams = stageAndGroup.currentGroup.groupMaxApplyExams!+1;
                                    // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                    updateGroupWorks();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text('New Apply Exam Added Successfully',style: TextStyle(color: Colors.orange),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text('Add New Exam'))),

                            ]),

                        dropdownValue == 'Maths'?
                        PopupMenuButton(
                            icon: const Icon(Icons.delete,color: Colors.red,size: 22,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    if( stageAndGroup.currentGroup.groupMaxQuizzes! >0){
                                      stageAndGroup.currentGroup.groupMaxQuizzes =  stageAndGroup.currentGroup.groupMaxQuizzes!-1;
                                      // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                      updateGroupWorks();
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text('Quiz Deleted  Successfully',style: TextStyle(color: Colors.white),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });


                                  },
                                  child: const Text('Delete Quiz'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    if( stageAndGroup.currentGroup.groupMaxHw!>0){
                                      stageAndGroup.currentGroup.groupMaxHw = stageAndGroup.currentGroup.groupMaxHw!-1;
                                      // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                      updateGroupWorks();
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text('H.W  Deleted  Successfully',style: TextStyle(color: Colors.white),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text('Delete H.W'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    if(stageAndGroup.currentGroup.groupMaxExams!>0){
                                      stageAndGroup.currentGroup.groupMaxExams =  stageAndGroup.currentGroup.groupMaxExams! -1;
                                      // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                      updateGroupWorks();
                                    }


                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text('Exam  Deleted  Successfully',style: TextStyle(color: Colors.white),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text(' Delete Exam'))),

                            ])
                            : PopupMenuButton(
                            icon: const Icon(Icons.delete,color: Colors.red,size: 22,),
                            itemBuilder: (context)=>[
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    if( stageAndGroup.currentGroup.groupMaxApplyQuizzes! >0){
                                      stageAndGroup.currentGroup.groupMaxApplyQuizzes = stageAndGroup.currentGroup.groupMaxApplyQuizzes! -1;
                                      // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                      updateGroupWorks();
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text('Apply Quiz Deleted  Successfully',style: TextStyle(color: Colors.white),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });


                                  },
                                  child: const Text('Delete Apply Quiz'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    if( stageAndGroup.currentGroup.groupMaxApplyHw! >0){
                                      stageAndGroup.currentGroup.groupMaxApplyHw =  stageAndGroup.currentGroup.groupMaxApplyHw! -1;
                                      // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                      updateGroupWorks();
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text('Apply H.W  Deleted  Successfully',style: TextStyle(color: Colors.white),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text('Delete Apply H.W'))),
                              PopupMenuItem(child: InkWell(
                                  onTap: (){
                                    if(stageAndGroup.currentGroup.groupMaxApplyExams! >0){
                                      stageAndGroup.currentGroup.groupMaxApplyExams = stageAndGroup.currentGroup.groupMaxApplyExams! -1 ;
                                      // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                                      updateGroupWorks();
                                    }


                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text('Apply Exam  Deleted  Successfully',style: TextStyle(color: Colors.white),),
                                        duration: const Duration(seconds: 5),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    setState(() {

                                    });
                                  },
                                  child: const Text(' Delete Apply Exam'))),

                            ])
                      ],
                    ),),
                  ],
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 33,
                  child: Container(
                    width: double.infinity,
                    decoration:  const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TabBarView(
                      children: [
                        dropdownValue=='Maths'?
                        MathsWidget(stageAndGroup.currentGroup,stageAndGroup.currentStage):
                        ApplyWidget(stageAndGroup.currentGroup,stageAndGroup.currentStage),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateGroupWorks(){
    for(int i=0;i<stageAndGroup.currentStage.totalGroupsOfStage!.length;i++){
      if(stageAndGroup.currentStage.totalGroupsOfStage![i].id==stageAndGroup.currentGroup.id){
        stageAndGroup.currentStage.totalGroupsOfStage![i]= stageAndGroup.currentGroup;
        // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentStage.totalGroupsOfStage![i]);
        break;
      }
    }
  }

  // Future<void> fetchAndStoreStudents() async {
  //   try {
  //     allSTUD = await StudentDatabase.readStudentsToListFromFir(FirebaseAuth.instance.currentUser!.uid, stageAndGroup.currentStage.id!, stageAndGroup.currentGroup.id!);
  //     numofstudents=allSTUD.length;
  //     int y=0,x=0;
  //     for(int i=0;i<allSTUD.length;i++){
  //       if(allSTUD[i].studentSubjects!.length==2){
  //         y++;
  //         x++;
  //       }
  //       else if(allSTUD[i].studentSubjects!.length==1){
  //         if(allSTUD[i].studentSubjects![0]=='Maths'){y++;}
  //         else {x++; }
  //       }
  //     }
  //     studentsMath=y;
  //     studentsApply=x;
  //     setState(() {
  //
  //     });
  //   } catch (e) {
  //     // Handle any errors that might occur during the data retrieval process
  //     print("Error fetching and storing student data: $e");
  //   }
  //
  // }
// getallstudent()async{
//    allStusent=  await StudentDatabase.readStudentsToListFromFirebase(FirebaseAuth.instance.currentUser!.uid, stageAndGroup.currentStage.id!, stageAndGroup.currentGroup.id!);
//    await allStusent.listen((List<Student> STUD) {
//      setState(() {
//        allSTUD = STUD;
//        numofstudents=STUD.length;
//        int y=0,x=0;
//        for(int i=0;i<STUD.length;i++){
//          if(allSTUD[i].studentSubjects!.length==2){
//            y++;
//            x++;
//          }
//          else if(allSTUD[i].studentSubjects!.length==1){
//            if(allSTUD[i].studentSubjects![0]=='Maths'){y++;}
//            else {x++; }
//          }
//        }
//        studentsMath=y;
//        studentsApply=x;
//
//
//      });
//
//   });
// }
}
class AllStageAndGroup{
  Stage newstage;
  Group newgroup;
  AllStageAndGroup(this.newstage,this.newgroup);

}
