import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolaby/screens/group/group_item.dart';
import 'package:tolaby/utiles/constant.dart';
class UpdateGroup extends StatefulWidget {
  static const String routeName = "Update Group";

  const UpdateGroup({super.key});

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController startStudentCodeController;
  var formkey = GlobalKey<FormState>();
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
    var stageAndGroup = ModalRoute.of(context)!.settings.arguments as StageAndGroup;
    titleController = TextEditingController(text: stageAndGroup.currentGroup.title);
    descriptionController = TextEditingController(text: stageAndGroup.currentGroup.place);
    startStudentCodeController = TextEditingController(text: stageAndGroup.currentGroup.groupStartStudentCode);

    return Scaffold(
      backgroundColor: primaryColorDark,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Group',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.fromLTRB(25, 32, 25, 50),
            elevation: 35,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
                    ],
                    onChanged: (text){
                      stageAndGroup.currentGroup.title = text;

                    },

                    validator: (text) {
                      if (text!.trim() == '') {
                        return "Enter Group Name";
                      }
                      return null;
                    },
                    controller: titleController,
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
                    onChanged: (text){
                      stageAndGroup.currentGroup.groupStartStudentCode = text;

                    },

                    validator: (text) {
                      if (text!.trim() == '') {
                        return "Enter Start Student Code";
                      }
                      return null;
                    },
                    controller: startStudentCodeController,
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
                    onChanged: (text){
                      stageAndGroup.currentGroup.place = text;
                    },

                    validator: (text) {
                      if (text!.trim() == '') {
                        return "Enter Group Description";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    style: const TextStyle(
                      color: Color.fromRGBO(36, 39, 43, 1.0),
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Enter Group Description',
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
                      labelText: 'Description',
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
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          if (stageAndGroup.currentGroup.groupRank != 1) {
                            stageAndGroup.currentGroup.groupRank--;
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
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '${stageAndGroup.currentGroup.groupRank}',
                        style: const TextStyle(fontSize: 21, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          ++stageAndGroup.currentGroup.groupRank;
                          setState(() {});
                        },
                        child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColorDark),
                            child: const Center(
                                child: Icon(
                              Icons.add,
                              size: 18,
                            ))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        Navigator.pop(context);
                        for (int i = 0; i <  stageAndGroup.currentStage.totalGroupsOfStage!.length; i++) {
                          if (stageAndGroup.currentStage.totalGroupsOfStage![i].id == stageAndGroup.currentGroup.id) {
                            stageAndGroup.currentStage.totalGroupsOfStage![i]=stageAndGroup.currentGroup;
                            // GroupDatabase.updateGroupInFirebase(stageAndGroup.currentGroup);
                            break;
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      visualDensity: VisualDensity.comfortable,
                      padding: const EdgeInsets.fromLTRB(35, 15, 35, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
