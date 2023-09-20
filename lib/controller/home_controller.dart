import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/mails_model.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';
import 'package:pal_mail_app/services/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeHelper {
  HomeHelper._();

  static final HomeHelper instance = HomeHelper._();

  Future<MailsModel> getmails() async {
    // try {
    //   final response = await http.get(Uri.parse(Keys.mailsUrl), headers: {
    //     'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}'
    //   });
    //   return mailsModelFromJson(response.body);
    // } catch (e) {
    //   flutterToastWidget(msg: "error", colors: Colors.redAccent);
    //   return MailsModel();
    // }
    ApiBaseHelper _helper = ApiBaseHelper();
    final response = _helper.get(Keys.mailsUrl, Keys.instance.header);
    Map<String, dynamic>? data;
    await response.then((value) {
      data = value;
    });

    return MailsModel.fromJson(data!);
  }
}
