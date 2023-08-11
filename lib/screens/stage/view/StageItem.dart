import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/screens/group/group_widget.dart';
import 'package:tolaby/screens/stage/view/UpdatstageView.dart';
import 'package:tolaby/screens/stage/widgets/ListTileComponent.dart';
import 'package:tolaby/screens/stage/widgets/ScreenLockComponent.dart';
import 'package:tolaby/services/Stages.dart';

class  StageItem extends StatelessWidget {
  Stage stage;
  StageItem(this.stage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Slidable(
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(20),
            onPressed: (context) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return ScreenLockComponent((){
                   StagesServices.deleatStage(id: stage.id!);
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
                  return ScreenLockComponent((){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, UpdateStage.routeName,arguments:stage);
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
        ]),
        child: InkWell(
          onTap: () {
           Navigator.pushNamed(context, GroupWidget.routeName,arguments: stage);
          },
          child: ListTileComponent(
            startStudentCode: "${stage.stageRank}",
            title: "${stage.title}",
            subtitle: "",
            total: "${stage.totalGroupsOfStageNumber}",
          ),
        ),
      ),
    );
  }
}
