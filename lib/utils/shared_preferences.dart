import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
