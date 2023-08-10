import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tolaby/screens/stage/stagebloc/stages_bloc.dart';
import 'package:tolaby/screens/stage/view/AddStageBottomSheetView.dart';
import 'package:tolaby/screens/stage/view/StageItem.dart';
import 'package:tolaby/services/Stages.dart';
import '../../../modles/stage_model.dart';
import '../../../utiles/constant.dart';

class StageView extends StatefulWidget {
  const StageView({Key? key}) : super(key: key);
  static String routName = 'Stage View';

  @override
  State<StageView> createState() => _StageViewState();
}

class _StageViewState extends State<StageView> {
  int numofstage = 0;
  int numofgroubs = 0;
  int studentsMath = 0;
  int studentsAbblay = 0;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 100));
    // if failed,use refreshFailed()
    if (mounted) {
      // fetchStagesData();
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      // fetchStagesData();
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StagesBloc()..add(StagesLoadedEvent()),
      child: BlocBuilder<StagesBloc, StagesState>(
        builder: (context, state) {
            return Scaffold(
              backgroundColor: primaryColorDark,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: const Text(
                  'Stages',
                  style: TextStyle(fontSize: 21),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        // fetchStagesData();
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                tooltip: 'Add New Stage',
                backgroundColor: Colors.white,
                onPressed: () {
                  showAddNewStageBottomsheet();
                },
                elevation: 8,
                shape: StadiumBorder(
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 3),
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              body: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(
                    waterDropColor: Colors.purple,
                    refresh: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                    complete: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Done',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ],
                    )),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text('Stages',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('$numofstage',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text('Groups',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('$numofgroubs',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Maths',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('$studentsMath',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.purple, Colors.blue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Apply',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('$studentsAbblay',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.5,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 8, left: 8, bottom: 20),
                        child: StreamBuilder<List<Stage>>(
                          stream: StagesServices.getStagesStream(), // Replace with the appropriate stream method
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final stages = snapshot.data!;
                              return ListView.builder(
                                itemCount: stages.length,
                                itemBuilder: (context, index) {
                                  return  StageItem(stages[index]);
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Center(child: CircularProgressIndicator()); // Loading indicator
                            }
                          },
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(8),
                    //     margin: const EdgeInsets.only(
                    //         right: 8, left: 8, bottom: 20),
                    //     child: ListView.builder(
                    //       itemBuilder: (context, index) {
                    //         return StageItem(state.stages[index]);
                    //       },
                    //       itemCount: state.stages.length,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );

        },
      ),
    );
  }

  void showAddNewStageBottomsheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddStageBottomSheetView(),
          );
        });
  }
}
