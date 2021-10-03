import 'package:shared_preferences/shared_preferences.dart';






class LocalStorage {


  static final String _pinCodeValue = '';


  static Future<String> getPinValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_pinCodeValue) ?? '';
  }

  static Future<bool> setPinValue(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_pinCodeValue, value);
  }
}



class AppStrings{

  static String setPIN = "";
}