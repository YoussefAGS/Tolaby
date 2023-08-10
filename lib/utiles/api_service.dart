import 'package:dio/dio.dart';

class ApiService{
 final Dio dio=Dio();
 final baseUrl="https://www.googleapis.com/books/v1/";

 ApiService();
  Future<Map<String,dynamic>> get ({required String endpoint})async{

  var response =await dio.get('$baseUrl$endpoint');
  return response.data;
 }
}