import 'package:easy_localization/easy_localization.dart';

class ErrorTranslator {
  static String translate(String errorCode) {
    switch (errorCode) {
      case 'invalidCredentials':
        return 'invalidCredentials'.tr();
      case 'loginError':
        return 'loginError'.tr();
      case 'emailAlreadyExists':
        return 'emailAlreadyExists'.tr();
      case 'signUpError':
        return 'signUpError'.tr();
      case 'databaseError':
        return 'databaseError'.tr();
      default:
        return errorCode; // Fallback al código original
    }
  }
}
