import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_and_task_manager/models/user_model.dart';

class UserService{
  final String baseUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<UserModel>> fetchUser() async {
    final url = Uri.parse(baseUrl);
    final response =  await http.get(url);

    if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
return data.map((e)=>UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to Load Users');
    }
  }
}
