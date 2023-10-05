import 'package:flutter/material.dart';
import 'package:pal_mail_app/controller/home_controller.dart';
import 'package:pal_mail_app/controller/user_controller.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/models/single_sender_model.dart' as send;
import 'package:pal_mail_app/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../controller/sender_profile_controller.dart';
import '../models/category_modl.dart';
import '../models/status_model.dart';
import '../models/tage_model.dart';
import 'new_inbox_provider.dart';

class HomeProvider with ChangeNotifier {
  List<Mail> mail = [];
  List<Mail> categoryOfficialOrganizations = [];
  List<Mail> categoryOther = [];
  List<Mail> categoryNGOs = [];
  List<Category> category = [];
  List<Mail> categoryForeign = [];
  List<String> tag = ["All Tags"];
  List? tagId = [0];
  List<StatusMails> statusMails = [];
  int countStatusInbox = 0;
  int countStatusInProgress = 0;
  int countStatusPending = 0;
  int countStatusCompleted = 0;
  int? statusMailsID;
  double xoffset = 0;
  double yoffset = 0;
  double scalefactor = 1;
  bool isdraweropen = false;
  String? roleId;
  send.SingleSenderModel? senderMails;
  final HomeHelper _homeHelper = HomeHelper.instance;
  Future<void> getRoleId() async {
    UserController user = UserController();
    await user.getLocalUser().then((value) {
      print(roleId = value.user.roleId);
      roleId = value.user.roleId;
      notifyListeners();
    });
  }

  Future<void> getFetchData() async {
    await getAllMails();
    await getStatusMails();
    await getTage();
    await getCategory();
  }

  Future<void> getFetchDataLoadding() async {
    await getAllMails();
    await getStatusMails();
    await getTage();
    await getCategory();
  }

  Future<void> getCategory() async {
    await _homeHelper.getCategory().then((value) {
      category.clear();
      categoryModelToJson(value);
      for (var element in value.categories!) {
        category.add(element);
      }
    });
  }

  Future<void> getAllMails() async {
    await _homeHelper.getMails().then((value) {
      mail.clear();
      mailsModelToJson(value);
      for (var element in value.mails!) {
        mail.add(element);
        countStatusMails(element);
        categoryMails(element);
      }
      print(mail.length);
    });
  }

  Future<void> getStatusMails() async {
    await _homeHelper.getStatusMails().then((value) {
      statusMails.clear();
      statusModelToJson(value);
      for (var element in value.statuses!) {
        statusMails.add(element);
      }
    });
  }

  Color countStatusMails(Mail mail) {
    if (mail.status!.name == "Inbox") {
      countStatusInbox++;
      return Colors.red;
    } else if (mail.status!.name == "In Progress" &&
        mail.status!.name != null) {
      countStatusInProgress++;
      return Colors.yellow;
    } else if (mail.status!.name == "Pending" && mail.status!.name != null) {
      countStatusPending++;
      return Colors.blueAccent;
    } else {
      countStatusCompleted++;
      return Colors.green;
    }
  }

  categoryMails(Mail mail) {
    if (mail.sender!.category!.id == 1) {
      categoryOther.add(mail);
    } else if (mail.sender!.category!.id == 2) {
      categoryOfficialOrganizations.add(mail);
    } else if (mail.sender!.category!.id == 3) {
      categoryNGOs.add(mail);
    } else if (mail.sender!.category!.id == 4) {
      categoryForeign.add(mail);
    }
  }

  int countCategoryMails(int id) {
    int count = 0;
    for (var element in mail) {
      if (element.sender!.category!.id == id) {
        count++;
      }
    }
    return count;
  }

  Future<void> getTage() async {
    await _homeHelper.getTage().then((value) {
      tag.clear();
      tagId!.clear();
      tagsModelToJson(value);
      for (var element in value.tags!) {
        tag.add(element.name!);
        tagId!.add(element.id);
      }
    });
  }

  setStatusMailsID(int id) {
    statusMailsID = id;
    notifyListeners();
  }

  void cleanDate() {
    mail.clear();
    countStatusInbox = 0;
    countStatusInProgress = 0;
    countStatusPending = 0;
    countStatusCompleted = 0;
  }

  void drawerClose(context) {
    final lanProv = Provider.of<LanguageProvider>(context, listen: false);
    if (lanProv.isEnglishLanguage) {
      xoffset = 320;
    } else {
      xoffset = -250;
    }
    yoffset = 90;
    scalefactor = 0.8;
    isdraweropen = true;
    notifyListeners();
  }

  void drawerOpen() {
    xoffset = 0;
    yoffset = 0;
    scalefactor = 1;
    isdraweropen = false;
    notifyListeners();
  }

  Future<void> getSenderMails(context, TextEditingController searchController,
      int index, int index2) async {
    final newInboxProv = Provider.of<NewInboxProvider>(context);
    SenderProfileController prof = SenderProfileController.instance;
    await prof
        .getSenderWithMails(searchController.text == ''
            ? newInboxProv.categories[index].senders![index2].id!
            : newInboxProv.filters[index].senders![index2].id!)
        .then((value) {
      senderMails = value;
    });
    notifyListeners();
  }
}
