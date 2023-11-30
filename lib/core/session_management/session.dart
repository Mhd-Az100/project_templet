abstract class GlobalSession {
  String? getToken();
  String? getLang();
  String? getFcmToken();
  String? getUser();

  //========================
  void setToken(String token);
  void setLang(String lang);
  void setFcmToken(String fcmToken);
  void setUser(String user);
}
