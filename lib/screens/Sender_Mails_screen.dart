import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:pal_mail_app/widgets/mails_widget.dart';
import 'package:provider/provider.dart';

import '../constants/keys.dart';
import '../constants/widget.dart';
import '../providers/details_mail_provider.dart';
import '../widgets/flutterToastWidget.dart';

class SenderMail extends StatelessWidget {
  int id;
  TextEditingController searchController;
  int index;
  int index2;
  SenderMail(
      {super.key,
      required this.id,
      required this.index,
      required this.index2,
      required this.searchController});
  Future<void> getSenderMails(context) async {
    final homeProv = Provider.of<HomeProvider>(context);
    await homeProv.getSenderMails(context, searchController, index, index2);
  }

  @override
  Widget build(BuildContext context) {
    final homeProv = Provider.of<HomeProvider>(context);
    getSenderMails(context);
    return Scaffold(
        body: homeProv.senderMails == null
            ? const Center(child: CircularProgressIndicator())
            : homeProv.senderMails!.sender.mails!.length != 0
                ? ListView.builder(
                    itemCount: homeProv.senderMails!.sender.mails!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30.r)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 18.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                      color: Color(int.parse(homeProv
                                              .senderMails!
                                              .sender
                                              .mails![index]
                                              .status!
                                              .color ??
                                          '0xff000000')),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.r),
                                      )),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Text(
                                  homeProv.senderMails!.sender.mails![index]
                                      .sender!.category!.name!,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat.yMMMd(
                                          context.localizations!.dateLan)
                                      .format(DateTime.parse(homeProv
                                          .senderMails!
                                          .sender
                                          .mails![index]
                                          .createdAt!
                                          .split('T')
                                          .first)),
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final detailsMailProvider =
                                        Provider.of<DetailsMailProvider>(
                                            context,
                                            listen: false);
                                    final homeProv = Provider.of<HomeProvider>(
                                        context,
                                        listen: false);
                                    await homeProv.getRoleId();
                                    if (homeProv.roleId == "2") {
                                      flutterToastWidget(
                                          msg:
                                              "You Must have permession to add mail",
                                          colors: Colors.orange);
                                    } else {
                                      // detailsMailProvider.setStatusMailsID(homeProv.senderMails!.sender
                                      //         .mails![index].status!.id!);
                                      // detailsMailProvider
                                      //     .setAttachmentList(mails.attachments);
                                      // detailsMailProvider.setActivityList(mails.activities);
                                      // // ignore: use_build_context_synchronously
                                      // navigatePush(
                                      //     context: context,
                                      //     nextScreen: DetailsMailScreen(mail: mails));
                                    }
                                  },
                                  child: const Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            ),
                            smallSpacer,
                            Text(
                              homeProv
                                  .senderMails!.sender.mails![index].subject!,
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                                homeProv.senderMails!.sender.mails![index]
                                        .description ??
                                    '',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.blueAccent,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis),
                            smallSpacer,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var element in homeProv.senderMails!
                                      .sender.mails![index].attachments!)
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: Image.network(
                                          '${Keys.baseUrlStorage}/${element.image!}',
                                          height: 46.h,
                                          width: 46.w,
                                          fit: BoxFit.fill),
                                    ),
                                ],
                              ),
                            ),
                            smallSpacer,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var element in homeProv
                                      .senderMails!.sender.mails![index].tags!)
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0.w),
                                      child: Text(
                                        "#${element.name}",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Theres no mails for this  Sender")));
  }
}
