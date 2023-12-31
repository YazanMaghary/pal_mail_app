import '../services/shared_preferences.dart';

class Keys {
  Keys._();

  static final Keys instance = Keys._();

  final Map<String, String> header = {
    'Authorization': 'Bearer ${SharedPreferencesHelper.user.token}',
    'Accept': 'application/json'
  };

  static const double screenWidth = 428;
  static const double screenHeight = 926;
  static const baseUrl = 'https://palmail.gsgtt.tech/api';
  static const baseUrlStorage = 'https://palmail.gsgtt.tech/storage';
  static const loginUrl = '$baseUrl/login';
  static const registerUrl = '$baseUrl/register';
  static const mailsUrl = '$baseUrl/mails';
  static const categoriesUrl = '$baseUrl/categories';
  static const tagsUrl = '$baseUrl/tags';
  static const searchUrl = '$baseUrl/search';
  static const statusUrl = '$baseUrl/statuses';
  static const attachmentUrl = '$baseUrl/attachments';
  static const sendersUrl = '$baseUrl/senders';
  static const userUrl = '$baseUrl/users';
  static const roleUrl = '$baseUrl/roles';
}

const String baseUrl = 'https://palmail.gsgtt.tech/api';
const categoUrl = '$baseUrl/categories';
const allMailsUrl = '$baseUrl/mails';
const allTagsUrl = '$baseUrl/tags';
