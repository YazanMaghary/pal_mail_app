// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/auth_controller.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/screens/guest_screen.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  bool isLogin = true;
  final AuthHelper _authHelper = AuthHelper.instance;
  double loginOpacity = 1;
  double signOpacity = 0;
  String? roleId;
  void isLoginScreen() {
    isLogin = true;
    loginOpacity = 1;
    signOpacity = 0;
    notifyListeners();
  }

  void isSignScreen() {
    isLogin = false;
    signOpacity = 1;
    loginOpacity = 0;
    notifyListeners();
  }

  Future<void> loginUser(Map<String, String> data, BuildContext context) async {
    await _authHelper.login(data, context).then((value) async {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      await homeProvider.getFetchData();
      roleId = value!;
    });
  }

  Future<void> registerUser(
      Map<String, String> data, BuildContext context) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await _authHelper.register(data, context).then((value) async {
      if (value) {
        await homeProvider.getFetchData();
        navigatePushReplacement(
            context: context, nextScreen: const GuestScreen());
      }
    });
  }
}
