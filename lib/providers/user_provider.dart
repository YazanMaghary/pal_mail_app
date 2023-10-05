import 'package:flutter/material.dart';
import '../controller/user_controller.dart';
import '../models/user_model.dart';
import '../services/helper/api_response.dart';
import '../models/all_user_model.dart' as user;

class UserProvider extends ChangeNotifier {
  late UserController _userController;
  late ApiResponse<UserModel> _data;
  List<user.User> users = [];
  List<String>? selectedValue;
  int userId = 0;
  int roleId = 0;
  UserProvider() {
    _userController = UserController();
    getUserData();
  }
  ApiResponse<UserModel> get data => _data;
  void updatuser() {
    getUserData();
  }

  Future<void> getUsersData() async {
    await _userController.getUsers().then((value) {
      users = value.users;
      for (var i = 0; i < users.length; i++) {
        selectedValue?.add('');
      }
      notifyListeners();
    });
  }

  Future<void> updateRole(int userid, int role) async {
    roleId = role;
    userId = userid;
    await _userController.userRoleUpdate(userId, roleId);
    notifyListeners();
  }

  Future<void> getUserData() async {
    _data = ApiResponse.loading('Loading');

    notifyListeners();
    try {
      final response = await _userController.getLocalUser();
      _data = ApiResponse.completed(response);

      notifyListeners();
    } catch (e) {
      _data = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
