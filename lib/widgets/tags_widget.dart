// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

import '../constants/colors.dart';
import '../screens/tag_search_screen.dart';

class TagsWidget extends StatelessWidget {
  List<String> tag;
  List tagId;
  TagsWidget({super.key, required this.tag, required this.tagId});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tag.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3,
          crossAxisCount: 3,
          mainAxisSpacing: 4.h,
          crossAxisSpacing: 4.w),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: InkWell(
            onTap: () {
              print(tagId[index]);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagSearchScreen(
                      tagId: tagId[index],
                    ),
                  ));
            },
            child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: tagButtonColor),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "#${tag[index]}",
                    style: TextStyle(
                      color: tagTextColor,
                      fontSize: 16.sp,
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
