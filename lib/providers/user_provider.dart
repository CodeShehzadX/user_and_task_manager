import 'package:flutter/material.dart';
import 'package:user_and_task_manager/models/user_model.dart';
import 'package:user_and_task_manager/services/user_service.dart';


class UserProvider extends ChangeNotifier{
  final _service = UserService();

  bool isLoading = false;
  String? errorMessage;
  List<UserModel> users= [];

  Future <void> LoadUsers()async{
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try{
      users = await _service.fetchUser();

      if(users.isEmpty){
        errorMessage = "No USer Found";
      }
    }catch(e){
      errorMessage = "Something Went Wrong";
    }
    isLoading = false;
    notifyListeners();
  }

}