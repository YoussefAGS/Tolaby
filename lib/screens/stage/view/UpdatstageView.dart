import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolaby/screens/stage/view/stage_view.dart';
import 'package:tolaby/screens/stage/stagebloc/stages_bloc.dart';
import 'package:tolaby/services/Stages.dart';

import '../../../modles/stage_model.dart';
import '../../../utiles/constant.dart';

class UpdateStage extends StatelessWidget {
  static const String routeName = "UpdateStage";
  UpdateStage({Key? key}) : super(key: key);
  TextEditingController stageTitleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Stage stage = ModalRoute.of(context)!.settings.arguments as Stage;
    stageTitleController = TextEditingController(text: stage.title);
    subjectController = TextEditingController(text: "gg");

    return BlocProvider(
      create: (context) => StagesBloc(),
      child: Scaffold(
        backgroundColor: primaryColorDark,
        appBar: AppBar(
          title: const Text('Edit Stage'),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white, size: 30),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 50),
              elevation: 35,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    TextFormField(
                      textDirection: TextDirection.ltr,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
                      ],
                      onChanged: (text) {
                        stage.title = text;
                      },
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
                            fontWeight: FontWeight.normal),
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
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9 :\\-\\.\\(\\)]')),
                      ],
                      onChanged: (text) {
                        // stage.subject = text;
                      },
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
                      textInputAction: TextInputAction.done,
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
                            if (stage.stageRank != 1) {
                              stage.stageRank--;
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
                          '${stage.stageRank}',
                          style: const TextStyle(
                              fontSize: 21, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            stage.stageRank++;
                            // setState(() {});
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
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    BlocBuilder<StagesBloc, StagesState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await StagesServices.updateStags(
                                  title: stage.title ?? " ",
                                  id: stage.id ?? " ");
                              Navigator.pop(context); // Pop from the current screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StageView(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(35, 15, 35, 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
