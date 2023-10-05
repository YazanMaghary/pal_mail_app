import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pal_mail_app/controller/sender_profile_controller.dart';
import 'package:pal_mail_app/providers/home_provider.dart';
import 'package:pal_mail_app/screens/Sender_Mails_screen.dart';
import 'package:pal_mail_app/services/localizations_extention.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/widget.dart';
import '../providers/new_inbox_provider.dart';
import '../widgets/navigate_widget.dart';
import '../widgets/text_field_widget.dart';

class SenderScreen extends StatefulWidget {
  const SenderScreen({Key? key}) : super(key: key);

  @override
  State<SenderScreen> createState() => _SenderScreenState();
}

class _SenderScreenState extends State<SenderScreen> {
  Future<void> getData() async {
    await Provider.of<NewInboxProvider>(context, listen: false).getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              navigatePop(context: context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.grey[600],
          ),
          title: Text(
            "Senders",
            style: TextStyle(color: Colors.grey[600]),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Consumer<NewInboxProvider>(
          builder: (context, newInboxProv, _) {
            return TweenAnimationBuilder(
              curve: Curves.linear,
              builder: (BuildContext context, double? height, Widget? child) {
                return SizedBox(
                  height: height,
                  child: Column(
                    children: [
                      mediumSpacer,
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: textFormFieldWidget(
                              radius: 60,
                              onSaved: (p0) {},
                              hintText: context.localizations!.sendersearch,
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.search)),
                              suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    searchController.text = '';
                                  },
                                  icon: const Icon(Icons.cancel)),
                              colors: const Color(0xffE6E6E6),
                              outlinedBorder: true,
                              controller: searchController,
                              onChange: (value) {
                                newInboxProv.searchController =
                                    searchController.text;
                                newInboxProv.Filters();
                                print(searchController.text);
                              },
                              onSubmit: () {},
                              type: TextInputType.text),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 24.h),
                          alignment: Alignment.topLeft,
                          child: newInboxProv.categories.isEmpty
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
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '________',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xffC0BFC2)),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Color(0xffC0BFC2),
                                          ),
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 5,
                                            itemBuilder: (context, index2) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.account_circle,
                                                        color:
                                                            Color(0xff7C7C7C),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '_______________________________',
                                                            style: TextStyle(
                                                                fontSize: 24.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          const Text(
                                                              '______________________'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                    color: Color(0xffC0BFC2),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          mediumSpacer
                                        ],
                                      );
                                    },
                                  ))
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  // ignore: unrelated_type_equality_checks
                                  itemCount: searchController.text.isEmpty
                                      ? newInboxProv.categories.length
                                      : newInboxProv.filters.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: searchController.text == ''
                                              ? Text(
                                                  newInboxProv
                                                      .categories[index].name!,
                                                  style: const TextStyle(
                                                      color: Color(0xffC0BFC2)),
                                                )
                                              : Text(
                                                  newInboxProv
                                                      .filters[index].name!,
                                                  style: const TextStyle(
                                                      color: Color(0xffC0BFC2)),
                                                ),
                                        ),
                                        const Divider(
                                          thickness: 1,
                                          color: Color(0xffC0BFC2),
                                        ),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: searchController.text == ''
                                              ? newInboxProv.categories[index]
                                                  .senders!.length
                                              : newInboxProv
                                                  .filters[index].senders!
                                                  .where((element) => element
                                                      .name!
                                                      .contains(searchController
                                                          .text))
                                                  .toList()
                                                  .length,
                                          itemBuilder: (context, index2) {
                                            return InkWell(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      Colors.transparent),
                                              splashFactory:
                                                  NoSplash.splashFactory,
                                              onTap: () async {
                                                final homeProv =
                                                    Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false);
                                                homeProv.senderMails = null;
                                                navigatePush(
                                                    context: context,
                                                    nextScreen: SenderMail(
                                                        index: index,
                                                        index2: index2,
                                                        searchController:
                                                            searchController,
                                                        id: searchController
                                                                    .text ==
                                                                ''
                                                            ? newInboxProv
                                                                .categories[
                                                                    index]
                                                                .senders![
                                                                    index2]
                                                                .id!
                                                            : newInboxProv
                                                                .filters[index]
                                                                .senders![
                                                                    index2]
                                                                .id!));
                                              },
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.account_circle,
                                                        color:
                                                            Color(0xff7C7C7C),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          searchController.text ==
                                                                  ''
                                                              ? Text(newInboxProv
                                                                  .categories[
                                                                      index]
                                                                  .senders![
                                                                      index2]
                                                                  .name!)
                                                              : Text(newInboxProv
                                                                  .filters[
                                                                      index]
                                                                  .senders!
                                                                  .where((element) => element
                                                                      .name!
                                                                      .contains(
                                                                          searchController
                                                                              .text))
                                                                  .toList()[
                                                                      index2]
                                                                  .name!),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          searchController.text ==
                                                                  ''
                                                              ? Text(newInboxProv
                                                                  .categories[
                                                                      index]
                                                                  .senders![
                                                                      index2]
                                                                  .mobile!)
                                                              : Text(newInboxProv
                                                                  .filters[
                                                                      index]
                                                                  .senders!
                                                                  .where((element) => element
                                                                      .name!
                                                                      .contains(
                                                                          searchController
                                                                              .text))
                                                                  .toList()[
                                                                      index2]
                                                                  .mobile!),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 1,
                                                    color: Color(0xffC0BFC2),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        mediumSpacer
                                      ],
                                    );
                                  }),
                        ),
                      )
                    ],
                  ),
                );
              },
              duration: const Duration(milliseconds: 500),
              tween: Tween<double>(
                  begin: MediaQuery.of(context).size.height - 500.h,
                  end: MediaQuery.of(context).size.height - 50),
            );
          },
        ),
      ),
    );
  }
}
