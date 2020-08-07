import 'package:shared_preferences/shared_preferences.dart';

class DataFunctions {
  static String sharedPreferenceAuthKey = "isAuth";
  static String sharedPreferenceUsernameKey = "usernameKey";
  static String sharedPreferenceEmailKey = "emailKey";

  Future<bool> saveUserAuth(bool isAuth) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(sharedPreferenceAuthKey, isAuth);
  }

  Future<bool> saveUsername(String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(
        sharedPreferenceUsernameKey, username);
  }

  Future<bool> saveEmail(String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(sharedPreferenceEmailKey, email);
  }

  // get the shared prefernce data
  Future<bool> getUserAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(sharedPreferenceAuthKey);
  }

  Future<String> getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceUsernameKey);
  }

  Future<String> getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(sharedPreferenceEmailKey);
  }
}
