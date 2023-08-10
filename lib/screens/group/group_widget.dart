
import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tolaby/modles/group_model.dart';
import 'package:tolaby/modles/stage_model.dart';
import 'package:tolaby/services/Groups.dart';
import 'package:tolaby/utiles/constant.dart';
import 'add_group.dart';
import 'group_item.dart';

class GroupWidget extends StatefulWidget {
  static const String routeName = 'Group Widget';

  const GroupWidget({super.key});

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {

  // final RefreshController _refreshController = RefreshController(initialRefresh: true);
  // void _onRefresh() async{
  //   // monitor network fetch
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   // if failed,use refreshFailed()
  //   _refreshController.refreshCompleted();
  // }
  //
  // void _onLoading() async{
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   if(mounted) {
  //     setState(() {
  //
  //     });
  //   }
  //   _refreshController.loadComplete();
  // }
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
    Stage stage = ModalRoute.of(context)!.settings.arguments as Stage;

    return  Scaffold(
      backgroundColor: primaryColorDark,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          '${stage.title}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 32),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Group',
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, AddGroupWidget.routeName, arguments: stage);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8, left: 8,),
              child: StreamBuilder<List<Group>>(
                stream: GroupServices.getGroupStream(stageId: stage.id!), // Replace with the appropriate stream method
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final groups = snapshot.data!;
                    return ListView.builder(
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        return  GroupItem(groups[index],stage);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(child: CircularProgressIndicator()); // Loading indicator
                  }
                },
              ),
              // child: StreamBuilder<QuerySnapshot<Group>>(
              //   stream: GroupDatabase.readGroupsFormFirebase('${stage.teacherId}','${stage.id}'),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Center(
              //           child: Text(
              //               'Group View: ${snapshot.error.toString()}'));
              //     } else if (snapshot.hasData) {
              //       var groups = snapshot.data!.docs
              //           .map((e) => e.data())
              //           .toList();
              //       groups.sort((a, b) => a.groupRank.compareTo(b.groupRank));
              //
              //       return ListView.builder(
              //         itemBuilder: (context, index) {
              //           return GroupItem(groups[index],stage);
              //         },
              //         itemCount: groups.length,
              //       );
              //     } else {
              //       return const Center(
              //           child: CircularProgressIndicator());
              //     }
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
