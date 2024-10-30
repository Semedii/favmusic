import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
