import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesService {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    try {
      prefs = await SharedPreferences.getInstance();
      print('prefs is setup Successfully');
    } catch (e) {
      print('Failed to initialize preferences: $e');
    }
  }

  static bool get isOnBoardingSeen {
    // تحقق من أن prefs ليست null قبل الوصول إليها
    if (prefs == null) {
      throw Exception('PreferencesService not initialized');
    }
    return prefs!.getBool('isOnBoardingSeen') ?? false;
  }

  static set isOnBoardingSeen(bool value) {
    if (prefs == null) {
      throw Exception('PreferencesService not initialized');
    }
    prefs!.setBool('isOnBoardingSeen', value);
  }
}
