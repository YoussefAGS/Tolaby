import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {

  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode}');
    }
  }

  Stream<dynamic> getStream({required String url, String? token}) async* {
    while (true) {
      try {
        Map<String, String> headers = {};
        if (token != null) {
          headers.addAll({'Authorization': 'Bearer $token'});
        }
        http.Response response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          yield jsonDecode(response.body);
        } else {
          throw Exception('there is a problem with status code ${response.statusCode}');
        }
      } catch (error) {
        yield error; // Emit the error through the stream
      }
      await Future.delayed(Duration(seconds: 5)); // Delay before fetching again
    }
  }


  Future<dynamic> post(
      {required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    http.Response response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    print('url = $url body = $body token = $token ');
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

  Future<void> deleteData({required String url}) async {// Replace with your API endpoint
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Data deleted successfully');
    } else {
      print('Failed to delete data. Status code: ${response.statusCode}');
    }
  }
}
