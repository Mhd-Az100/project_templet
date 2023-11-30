import 'package:shared_preferences/shared_preferences.dart';

import 'session.dart';

class GlobalSessionImpl implements GlobalSession {
  final SharedPreferences sharedPref;

  GlobalSessionImpl(this.sharedPref);

  @override
  String? getToken() {
    return sharedPref.getString("token");
  }

  @override
  String? getLang() {
    return sharedPref.getString("lang");
  }

  @override
  String? getFcmToken() {
    return sharedPref.getString("fcm_token");
  }

  @override
  String? getUser() {
    return sharedPref.getString("user");
  }

  //=================================

  @override
  void setToken(String token) {
    sharedPref.setString("token", token);
  }

  @override
  void setLang(String lang) {
    sharedPref.setString("lang", lang);
  }

  @override
  void setFcmToken(String fcmToken) {
    sharedPref.setString("fcm_token", fcmToken);
  }

  @override
  void setUser(String user) {
    sharedPref.setString("user", user);
  }
}
