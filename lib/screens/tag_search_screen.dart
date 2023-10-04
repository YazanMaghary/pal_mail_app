import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/controller/home_controller.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/widgets/mails_widget.dart';
import 'package:pal_mail_app/widgets/navigate_widget.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../constants/widget.dart';
import '../providers/tags_provider.dart';

class TagSearchScreen extends StatelessWidget {
  int tagId;

  TagSearchScreen({
    super.key,
    required this.tagId,
  });
  Future<void> getData(context) async {
    final prov = Provider.of<TagsProvider>(context, listen: false);
    await prov.getTagsProv();
    await prov.isSelected();
    prov.selectedBefore(tagId);
    await prov.mailFilterByTagId();
  }

  @override
  Widget build(BuildContext context) {
    getData(context);
    final prov = Provider.of<TagsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tags",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              prov.clearTags();
              prov.mailByTags.clear();
              navigatePop(context: context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
      ),
      body: SizedBox(
        child: Consumer<TagsProvider>(
          builder: (context, tagsProvider, child) {
            return Column(
              children: <Widget>[
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.r)),
                                ),
                                child: tagsProvider.tagsName.isEmpty ||
                                        tagsProvider.selected.isEmpty
                                    ? Shimmer(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 134, 134, 136),
                                            Color.fromARGB(255, 150, 149, 149),
                                            Color.fromARGB(255, 243, 243, 245),
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
                                                  padding:
                                                      EdgeInsets.all(4.w.h),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.r),
                                                      color:
                                                          tagButtonColornotSelected),
                                                  child: Text(
                                                    "#________",
                                                    style: TextStyle(
                                                        color: tagTextColor,
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            );
                                          },
                                        ))
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: tagsProvider.tagsName.isEmpty
                                            ? 0
                                            : tagsProvider.tagsName.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 3,
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 4.h,
                                                crossAxisSpacing: 4.w),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              tagsProvider.isSelected();
                                              tagsProvider
                                                  .isSelectedStateForSearch(
                                                      index);
                                              await tagsProvider
                                                  .mailFilterByTagId();

                                              print(
                                                  tagsProvider.tagsIdForSearch);
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.r),
                                                    color: tagsProvider
                                                                    .selected[
                                                                index] ||
                                                            tagsProvider.tags
                                                                    .elementAt(
                                                                        index)
                                                                    .id ==
                                                                tagsProvider
                                                                    .tagsIdForSearch
                                                        ? tagButtonColorSelected
                                                        : tagButtonColornotSelected),
                                                child: Text(
                                                  "#${tagsProvider.tagsName.elementAt(index)}",
                                                  style: TextStyle(
                                                    color: tagsProvider
                                                                    .selected[
                                                                index] ||
                                                            tagsProvider.tags
                                                                    .elementAt(
                                                                        index)
                                                                    .id ==
                                                                tagsProvider
                                                                    .tagsIdForSearch
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
                          tagsProvider.mailByTags.isEmpty
                              ? Expanded(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            mainAxisSpacing: 4.h,
                                            crossAxisSpacing: 4.w),
                                    itemBuilder: (context, index) {
                                      return Shimmer(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 199, 199, 201),
                                            Color.fromARGB(255, 230, 229, 229),
                                            Color.fromARGB(255, 243, 243, 245),
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
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 20.h),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.r)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 18.w,
                                                    height: 18.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                      Radius.circular(20.r),
                                                    )),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Text(
                                                    '_________',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "Today, 11:00 AM",
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  const Icon(
                                                      Icons.arrow_forward_ios),
                                                ],
                                              ),
                                              smallSpacer,
                                              Text(
                                                '_______________',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                ),
                                              ),
                                              Text(
                                                  '_______________________________',
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                  ),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                              smallSpacer,
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.w),
                                                      child: Container(
                                                        width: 46.6,
                                                        height: 46.6.h,
                                                        child: const Text(''''''
                                                            ''''''),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              smallSpacer,
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "#tag",
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                  itemCount: tagsProvider.mailByTags.length,
                                  itemBuilder: (context, index) {
                                    return mailsWidget(
                                        mails: tagsProvider.mailByTags[index],
                                        context: context);
                                  },
                                ))
                        ],
                      )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
