import 'package:pal_mail_app/constants/keys.dart';
import 'package:pal_mail_app/models/single_sender_model.dart';
import 'package:pal_mail_app/services/helper/api_base_helper.dart';

class SenderProfileController {
  SenderProfileController._();

  static final SenderProfileController instance = SenderProfileController._();
  Future<SingleSenderModel> getSenderWithMails(int id) async {
    ApiBaseHelper _helper = ApiBaseHelper();
    final response = await _helper.get(
        "${Keys.sendersUrl}/$id?mail=true", Keys.instance.header);
    return SingleSenderModel.fromJson(response);
  }
}
