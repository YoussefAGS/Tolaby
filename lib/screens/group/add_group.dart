import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolaby/modles/group_model.dart';
import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/services/Groups.dart';
import 'package:tolaby/utiles/constant.dart';

class AddGroupWidget extends StatefulWidget {
  static const String routeName = 'StageWidget';

  const AddGroupWidget({super.key});

  @override
  State<AddGroupWidget> createState() => _AddGroupWidgetState();
}

class _AddGroupWidgetState extends State<AddGroupWidget> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int rank = 1;

  TextEditingController groupTitleController = TextEditingController();

  TextEditingController groupPlaceController = TextEditingController();
  TextEditingController groupStartStudentCodeController = TextEditingController();
late  Stage stage;
  StreamSubscription? connection;
  bool isoffline = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     stage = ModalRoute.of(context)!.settings.arguments as Stage;
     rank = stage.groupRank;
    return Scaffold(
      backgroundColor: primaryColorDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Create New Group',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Card(
            elevation: 33,
            margin:
                const EdgeInsets.only(top: 16, bottom: 32, right: 20, left: 20),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${stage.title}',style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(height: 8,),
                  Image.asset(
                    'assets/group.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextFormField(
                    textDirection:TextDirection.ltr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
                    ],

                    validator: (text) {
                      if (text!.trim() == '') {
                        return "Enter Group Name";
                      }
                      return null;
                    },
                    controller: groupTitleController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter Group Name',
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      focusColor: Colors.cyan,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: 'Group Name',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,

                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
                    ],

                    validator: (text) {
                      if (text!.trim() == '') {
                        return "Enter Start Student Code";
                      }
                      return null;
                    },
                    controller: groupStartStudentCodeController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Enter Start Student Code',
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      focusColor: Colors.cyan,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: ' Start Student Code',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,

                    validator: (text) {
                      if (text!.trim() == '') {
                        return "Enter Group Description";
                      }
                      return null;
                    },
                    controller: groupPlaceController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: 'Enter Group Description',
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                      ),
                      focusColor: Colors.cyan,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: 'Group Description',
                      labelStyle: const TextStyle(
                          color: Color.fromRGBO(121, 121, 121, 1.0),
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Rank : ',
                        style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16,),
                      InkWell(
                        onTap: () {
                          if(rank != 1){
                            rank--;
                          }
                          setState(() {});
                        },
                        child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColorDark),
                            child: const Center(
                              child: Text(
                                '-',
                                style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(width: 16,),
                      Text(
                        '$rank',
                        style: const TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      const SizedBox(width: 16,),
                      InkWell(
                        onTap: () {
                          rank++;
                          setState(() {});
                        },
                        child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColorDark),
                            child: const Center(
                                child:Icon(Icons.add,size: 18,)
                            )
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.comfortable,
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.fromLTRB(70, 10, 70, 10))),
                    onPressed: () {
                     validateGroupForm();
                    },
                    child: const Text('Create',
                        style: TextStyle(
                          fontSize: 18,
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

  void validateGroupForm(){
    if (formkey.currentState!.validate()) {
      Navigator.pop(context);
      Group group = Group(
        groupsMessages: [],
        groupRank:rank,
        groupTotalApplyStudents: 0,
        groupTotalMathsStudents: 0,
        teacherId: stage.teacherId,
        title: groupTitleController.text,
        place: groupPlaceController.text,
        groupTotalStudents: 0,
        groupStartStudentCode: groupStartStudentCodeController.text,
        stageIdOfGroup: stage.id,
        groupMaxExams: 0,
        groupMaxHw: 0,
        groupMaxQuizzes: 0,
        groupMaxApplyExams: 0,
        groupMaxApplyHw: 0,
        groupMaxApplyQuizzes: 0,
        groupStudents: [],
      );
      ++stage.groupRank;
      ++stage.totalGroupsOfStageNumber;
      GroupServices.addGroup(group: group);
    }
  }

}
