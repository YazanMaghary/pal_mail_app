import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/constants/colors.dart';
import 'package:pal_mail_app/constants/images.dart';
import 'package:pal_mail_app/constants/widget.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/widgets/status_mail_widget.dart';
import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_sheet_widget.dart';
import '../widgets/tags_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      bottomSheet: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: colorWhite,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w)),
          onPressed: () {
            CustomModalBottomSheet(context: context).show();
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: inboxtextColor,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Icon(
                  Icons.add_outlined,
                  size: 24.w.h,
                  color: colorWhite,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "New Inbox",
                style: TextStyle(fontSize: 20, color: inboxtextColor),
              )
            ],
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            largeSpacer,
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notes_sharp,
                    size: 30.sp,
                  ),
                  onPressed: () async {},
                ),
                const Spacer(),
                Image.asset(
                  Images.personIcon,
                ),
              ],
            ),
            textFormFieldWidget(
                outlinedBorder: false,
                controller: searchController,
                type: TextInputType.text,
                validate: (value) {
                  return null;
                },
                hintText: "search",
                prefixIcon: Icons.search,
                colors: Colors.white),
            mediumSpacer,
            Row(
              children: [
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.red,
                      countMail: homeProvider.countStatusInbox,
                      status: "Inbox"),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.yellow,
                      countMail: homeProvider.countStatusPending,
                      status: "Pending"),
                ),
              ],
            ),
            smallSpacer,
            Row(
              children: [
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.blueAccent,
                      countMail: homeProvider.countStatusInProgress,
                      status: "In progress"),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: statusMailWidget(
                      colors: Colors.green,
                      countMail: homeProvider.countStatusCompleted,
                      status: "Completed"),
                ),
              ],
            ),
            // Expanded Tile widget start
            // Expanded Tile widget end
            Container(
              padding: EdgeInsets.all(16.w.h),
              alignment: Alignment.centerLeft,
              child: Text(
                "Tags",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            // Tags start
            const TagsWidget(),
            // Tags End
          ],
        ),
      ),
    );
  }
}
