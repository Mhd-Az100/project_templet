import 'package:easy_localization/easy_localization.dart';

/// Validator class

class Validator {
  static String? validatePhone(String? phone) {
    if (phone!.isEmpty) {
      return "field_required".tr();
    } else if (phone.length < 9) {
      return "wrong_phone".tr();
    }
    return null;
  }


  static String? validateText(String? value) {
    if (value!.isEmpty) {
      return "field_required".tr();
    }
    return null;
  }
  // 
  static String? validateTime(DateTime? value) {
  if (value == null) {
    return "field_required".tr();
  }
  return null;
}
 
 
}
