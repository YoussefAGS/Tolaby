
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tolaby/screens/stage/view/stage_view.dart';
import 'package:tolaby/services/Stages.dart';
import 'package:tolaby/utiles/constant.dart';

import '../../../modles/stage_model.dart';


class AddStageBottomSheetView extends StatefulWidget {
   AddStageBottomSheetView({Key? key}) : super(key: key);

  @override
  State<AddStageBottomSheetView> createState() => _AddStageBottomSheetViewState();
}

class _AddStageBottomSheetViewState extends State<AddStageBottomSheetView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController stageTitleController = TextEditingController();

  TextEditingController subjectController = TextEditingController();

  int rank = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 32, ),
                child: Text(
                  'Create New Stage',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormField(
                textDirection: TextDirection.ltr,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 -\\.\\(\\)]')),
                ],

                validator: (text) {
                  if (text!.trim() == '') {
                    return "Enter Stage Title";
                  }
                  return null;
                },
                controller: stageTitleController,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  color: Color.fromRGBO(36, 39, 43, 1.0),
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter Stage Title',
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
                  labelText: 'Title',
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
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 -\\.\\(\\)]')),
                ],
                validator: (text) {
                  if (text!.trim() == '') {
                    return "Enter Subject Name";
                  }
                  return null;
                },
                controller: subjectController,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  color: Color.fromRGBO(36, 39, 43, 1.0),
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter Subject Name',
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
                  labelText: 'Subject Name',
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
                height: MediaQuery.of(context).size.height * 0.06,
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
                  validateStageForm();
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
    );
  }

   void validateStageForm() async {
     if (formKey.currentState!.validate()) {
       Stage stage = Stage(
         teacherId:teacherr.teacher?.id,
         title: stageTitleController.text,
         // subject: subjectController.text,
         totalStudentsOfStage: [],
         totalStudentsOfStageNumber: 0,
         totalStudentsOfApplyStageNumber: 0,
         totalGroupsOfStage: [],
         totalGroupsOfStageNumber: 0,
         stageRank: rank,
         groupRank: 1,
         totalAttendanceGroups: 0,
         groupAttendanceRank: 1,
         stageStudentsRank: 10,
       );
       StagesServices.addStageStream(stage: stage);
       Navigator.pop(context); // Pop from the current screen
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(
           builder: (context) => StageView(),
         ),
       );

     }
   }
}
