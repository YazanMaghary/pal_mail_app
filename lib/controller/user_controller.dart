import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';

import '../models/all_user_model.dart' as userModel;
import '../models/user_model.dart';
import '../services/helper/shared_pref.dart';

class UserController {
  Future<UserModel> getLocalUser() async {
    SharedPrefsController prefs = SharedPrefsController();
    bool hasKey = await prefs.containsKey('user');
    if (hasKey) {
      dynamic userData = await prefs.getData('user');
      if (userData != null) {
        UserModel user = UserModel.fromJson(json.decode(userData));
        return user;
      }
    }
    return Future.error('not found');
  }

  Future<userModel.UserModel> getUsers() async {
    ApiBaseHelper _helper = ApiBaseHelper();
    final response = await _helper.get(Keys.userUrl, Keys.instance.header);
    return userModel.UserModel.fromJson(response);
  }

  Future<void> userRoleUpdate(int id, int roleId) async {
    ApiBaseHelper _helper = ApiBaseHelper();
    print("upupupupu");
    print(roleId);
    print("upupupupu");
    try {
      await _helper.put("${Keys.userUrl}/$id/role",
          {'role_id': roleId.toString()}, Keys.instance.header);
      flutterToastWidget(msg: "Role Updated", colors: Colors.green);
    } catch (e) {
      print(e);
      flutterToastWidget(msg: "Role Updated Failed", colors: Colors.red);
    }
  }
}

// Future<String> getUserNewImage() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   User user = userFromJson(prefs.getString('user')!);
//   final response = await http.get(Uri.parse('$baseUrl/user'),
//       headers: {'Authorization': 'Bearer ${user.token}'});
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     print('the data of the user is: $data');

//     User fetchedUser = User.fromJson(data);
//     print('the fetched user is $fetchedUser');

//     return fetchedUser.user.image!;
//   }

//   throw Exception('Error while fetching user data');
// }