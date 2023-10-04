import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/providers/tags_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/widgets/flutterToastWidget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';

import 'package:pal_mail_app/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/colors.dart';
import '../../constants/widget.dart';

class TagsBottomSheet {
  TextEditingController tagsController = TextEditingController();

  void showTagsSheet(context) async {
    final tagsProvider2 = Provider.of<TagsProvider>(context, listen: false);

    showModalBottomSheet(
      backgroundColor: Colors.grey[100],
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15.r), topLeft: Radius.circular(15.r))),
      context: context,
      builder: (BuildContext context) {
        return TweenAnimationBuilder(
          builder: (BuildContext context, double? value, Widget? child) {
            return SizedBox(
              height: value,
              child: Consumer<TagsProvider>(
                builder: (context, tagsProvider, child) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                tagsProvider.clearData();
                                tagsProvider.tagsId.clear();
                                tagsProvider.selected.clear();
                                tagsController.clear();
                                Navigator.pop(context);
                              },
                              child: Text(
                                context.localizations!.cancel,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                            Text(
                              context.localizations!.tags,
                              style: TextStyle(
                                  fontSize: 19.sp, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                tagsProvider.clearData();
                                navigatePop(context: context);
                              },
                              child: Text(
                                context.localizations!.done,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      smallSpacer,
                      Expanded(
                        flex: 10,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.all(5.w.h),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.r)),
                                      ),
                                      child: tagsProvider.tagsName.isEmpty
                                          ? Shimmer(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 134, 134, 136),
                                                  Color.fromARGB(
                                                      255, 150, 149, 149),
                                                  Color.fromARGB(
                                                      255, 243, 243, 245),
                                                ],
                                                stops: [
                                                  0.1,
                                                  0.3,
                                                  0.4,
                                                ],
                                                begin: Alignment(-1.0, -0.3),
                                                end: Alignment(1.0, 0.3),
                                                tileMode: TileMode.clamp,
                                              ),
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: 6,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        childAspectRatio: 3,
                                                        crossAxisCount: 3,
                                                        mainAxisSpacing: 4.h,
                                                        crossAxisSpacing: 4.w),
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () async {},
                                                    child: Container(
                                                        padding: EdgeInsets.all(
                                                            4.w.h),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.r),
                                                            color:
                                                                tagButtonColornotSelected),
                                                        child: Text(
                                                          "#________",
                                                          style: TextStyle(
                                                              color:
                                                                  tagTextColor,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                  );
                                                },
                                              ))
                                          : GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  tagsProvider.tagsName.isEmpty
                                                      ? 0
                                                      : tagsProvider
                                                          .tagsName.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 3,
                                                      crossAxisCount: 3,
                                                      mainAxisSpacing: 4.h,
                                                      crossAxisSpacing: 4.w),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    tagsProvider
                                                        .isSelectedState(index);
                                                    print(tagsProvider.tagsId);
                                                  },
                                                  child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.r),
                                                          color: tagsProvider
                                                                      .selected[
                                                                  index]
                                                              ? tagButtonColorSelected
                                                              : tagButtonColornotSelected),
                                                      child: Text(
                                                        "#${tagsProvider.tagsName.elementAt(index)}",
                                                        style: TextStyle(
                                                          color: tagsProvider
                                                                      .selected[
                                                                  index]
                                                              ? Colors.white
                                                              : tagTextColor,
                                                          fontSize: 16.sp,
                                                        ),
                                                      )),
                                                );
                                              },
                                            )),
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
                                Expanded(
                                  child: textFormFieldWidget(
                                    suffixIcon: IconButton(
                                        splashColor: Colors.transparent,
                                        onPressed: () async {
                                          if (tagsController.text.isNotEmpty) {
                                            await tagsProvider.createTags(
                                                name: tagsController.text);
                                            await tagsProvider.isSelected();
                                            tagsController.clear();
                                          } else {
                                            flutterToastWidget(
                                                msg: 'You Must Enter Tag Name',
                                                colors: Colors.red);
                                          }
                                        },
                                        icon: const Icon(Icons.send)),
                                    radius: 50.r,
                                    colors: colorWhite,
                                    hintText: context.localizations!.tagsadd,
                                    maxLines: 1,
                                    label: Text(context.localizations!.tags),
                                    outlinedBorder: true,
                                    controller: tagsController,
                                    type: TextInputType.text,
                                    validate: (p0) => '',
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
          tween: Tween<double>(
              begin: MediaQuery.of(context).size.height - 500.h,
              end: MediaQuery.of(context).size.height - 50),
        );
      },
    ).whenComplete(() {
      tagsController.clear();
      tagsProvider2.clearData();
    });
    await tagsProvider2.getTagsProv();
    await tagsProvider2.isSelected();
  }
}
