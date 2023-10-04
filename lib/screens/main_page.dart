import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pal_mail_app/providers/auth_provider.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/screens/guest_screen.dart';
import 'package:provider/provider.dart';
import 'drawer_screen.dart';
import 'home_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProv = Provider.of<HomeProvider>(context, listen: false);
    homeProv.getRoleId();
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, prov, child) {
          return Stack(children: [
            const DrawerScreen(),
            prov.roleId == '1' ? const GuestScreen() : const HomeScreen(),
          ]);
        },
      ),
    );
  }
}
