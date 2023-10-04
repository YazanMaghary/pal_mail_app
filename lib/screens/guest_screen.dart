import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/helper/shared_pref.dart';
import '../services/shared_preferences.dart';
import 'auth_screen.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          "assets/images/guest.jpg",
        ),
        fit: BoxFit.fill,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                SharedPreferencesHelper.deleteUser();
                SharedPrefsController h = SharedPrefsController();
                h.deleteData('user');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AuthScreen();
                }));
              },
              icon: const Icon(Icons.logout)),
          Center(
            child: Text(
              "Contact the Admin to get Permission",
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
          ),
        ],
      ),
    ));
  }
}
