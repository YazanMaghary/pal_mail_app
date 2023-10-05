import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  Future<void> getUsers(context) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    await user.getUsersData();
  }

  final List<String> items = [
    'guest',
    'user',
    'editor',
    'admin',
  ];

  @override
  Widget build(BuildContext context) {
    getUsers(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "User Management",
            style: TextStyle(color: Colors.grey[700]),
          ),
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.grey[700],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
          child: Consumer<UserProvider>(
            builder: (context, userProv, child) {
              return ListView.builder(
                itemCount: userProv.users.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Icon(
                        Icons.person_2_sharp,
                        color: Colors.grey[600],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProv.users[index].name!,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                userProv.users[index].email!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16.sp,
                                    color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              'Role',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: userProv.selectedValue?[index],
                            onChanged: (String? value) async {
                              userProv.selectedValue?[index] = value!;
                              print(value);
                              if (value == 'guest') {
                                await userProv.updateRole(
                                    userProv.users[index].id!, 1);
                              } else if (value == 'user') {
                                await userProv.updateRole(
                                    userProv.users[index].id!, 2);
                              } else if (value == 'editor') {
                                await userProv.updateRole(
                                    userProv.users[index].id!, 3);
                              } else {
                                await userProv.updateRole(
                                    userProv.users[index].id!, 4);
                              }
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              height: 40.h,
                              width: 140.w,
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: 40.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ));
  }
}
