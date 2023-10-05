import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/providers/language_provider.dart';
import 'package:pal_mail_app/screens/auth_screen.dart';
import 'package:pal_mail_app/screens/home_screen.dart';
import 'package:pal_mail_app/screens/main_page.dart';
import 'package:pal_mail_app/screens/profile_screen.dart';
import 'package:pal_mail_app/screens/sender_screen.dart';
import 'package:pal_mail_app/screens/setting_screen.dart';
import 'package:pal_mail_app/services/helper/shared_pref.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:pal_mail_app/controller/user_controller.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  Future<void> getRole(context) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.getRoleId();
  }

  @override
  Widget build(BuildContext context) {
    final lanProv = Provider.of<LanguageProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    List<Map> drawerItem = homeProvider.roleId == '2'
        ? [
            {'icon': Icons.home, 'title': context.localizations?.home},
            {'icon': Icons.person, 'title': context.localizations?.profilepage},
          ]
        : homeProvider.roleId == '3'
            ? [
                {'icon': Icons.home, 'title': context.localizations?.home},
                {
                  'icon': Icons.person,
                  'title': context.localizations?.profilepage
                },
                {
                  'icon': Icons.account_box,
                  'title': context.localizations?.senders
                },
              ]
            : [
                {'icon': Icons.home, 'title': context.localizations?.home},
                {
                  'icon': Icons.person,
                  'title': context.localizations?.profilepage
                },
                {
                  'icon': Icons.account_box,
                  'title': context.localizations?.senders
                },
                {
                  'icon': Icons.settings,
                  'title': context.localizations?.usermang
                },
              ];
    getRole(context);
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: lanProv.isEnglishLanguage
            ? EdgeInsets.only(top: 80.h, left: 20.w, bottom: 20.h)
            : EdgeInsets.only(top: 80.h, right: 20.w, bottom: 20.h),
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.15),
                height: 100.h,
                width: 100.w,
                child: const Image(
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/e/ee/Coat_of_arms_of_State_of_Palestine_%28Official%29.png'))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Column(
                children: drawerItem
                    .map((e) => Row(
                          children: [
                            Icon(
                              e['icon'],
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(
                              height: 50.h,
                              width: 10.w,
                            ),
                            TextButton(
                              onPressed: () async {
                                switch (e["title"]) {
                                  case "Home" || "الصفحة الرئيسية":
                                    final homeProv = Provider.of<HomeProvider>(
                                        context,
                                        listen: false);
                                    homeProv.drawerOpen();
                                    navigatePush(
                                        context: context,
                                        nextScreen: const MainPage());
                                  case "Senders" || "المرسلين":
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const SenderScreen();
                                      },
                                    ));
                                  case "Profile Page" || "الملف الشخصي":
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const ProfileScreen();
                                      },
                                    ));
                                  case "User Management" || "ادارة المستخدمين":
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SettingScreen();
                                      },
                                    ));

                                    break;
                                }
                              },
                              child: Text(
                                "${e['title']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ),
                          ],
                        ))
                    .toList()),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms Of Service',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 1.2.w,
                    height: 15.h,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Usage Policy',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 1.2.w,
                    height: 15.h,
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {
                      SharedPreferencesHelper.deleteUser();
                      SharedPrefsController h = SharedPrefsController();
                      h.deleteData('user');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AuthScreen();
                      }));
                    },
                    child: Text(
                      'LogOut',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
