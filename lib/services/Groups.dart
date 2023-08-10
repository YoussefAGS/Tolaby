import 'package:tolaby/modles/stage_model.dart';
import '../modles/group_model.dart';
import '../utiles/api.dart';
import 'package:http/http.dart' as http;


class GroupServices {
  static Future<List<Group>?> getGroup({required String stageId}) async {
    List<dynamic> response = await Api().get(url:'https://tolapyserver.onrender.com/stages/${stageId}/groups');
    int n = response.length;
    List<Group> products = [];
    for (int i = 0; i < n; i++) {
      products.add(Group.fromJson(response[i]));
    }
    return products;
  }
  static Stream<List<Group>> getGroupStream({required String stageId}) async* {
    while (true) {
      List<dynamic> response =
      await Api().get(url: 'https://tolapyserver.onrender.com/stages/${stageId}/groups');
      int n = response.length;
      List<Group> group = [];
      for (int i = 0; i < n; i++) {
        group.add(Group.fromJson(response[i]));
      }
      yield group;
      await Future.delayed(Duration(seconds: 5)); // Delay before fetching again
    }
  }
  ///---------------------------------------------------------------------------

  static Future<void> addGroup({required Group group}) async {
    await Api().post(url: "https://tolapyserver.onrender.com/groups", body: {
      "title": group.title,
      "place": group.place,
      "stageIdOfGroup": group.id,

    });
  }
  static Stream<void> addGroupStream({required Group group}) async* {
    await Api().post(url: "https://tolapyserver.onrender.com/groups", body: {
      "title": "${group.title}",
      "stageIdOfGroup": "${group.stageIdOfGroup}",
    });
  }

  ///---------------------------------------------------------------------------

  static Stream<Stage> updateStageStream({
  required Group group
  }) async* {
    Map<String, dynamic> response = await Api().put(url: 'https://tolapyserver.onrender.com/groups/${group.stageIdOfGroup}', body: {
      "title": "${group.title}",
      "groupStartStudentCode":"${group.groupStartStudentCode}",
      "place":"${group.place}"
    });
    yield Stage.fromJson(response);
  }
  static Future<Stage> updateGroup({required Group group}) async {
    Map<String, dynamic> response =
    await Api().put(url:'https://tolapyserver.onrender.com/groups/${group.stageIdOfGroup}', body: {
      "title": "${group.title}",
      "groupStartStudentCode":"${group.groupStartStudentCode}",
      "place":"${group.place}"
    });
    return Stage.fromJson(response);
  }


  ///---------------------------------------------------------------------------




  static Future<void> deleatGroup({required String id})async{
    await Api().deleteData(url:"https://tolapyserver.onrender.com/groups/${id}");
  }

  static Stream<void> deleteGroupStream({required String id}) async* {
    print("ffffffffffffffffffffffffffffffff${id}");
    await Api().deleteData(url: "https://tolapyserver.onrender.com/groups/${id}");
  }

}
