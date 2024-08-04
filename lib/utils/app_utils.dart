import 'dart:io';

class AppUtils {
  static String get appName => Platform.isAndroid
      ? "StepCounter-GPSTracking"
      : "Step Counter Pedometer-GPS Map";
  static const googleMapsApiKey = "AIzaSyCIB-7DOsSUhZeqIfz3k3scAjvdD6j_OAE";

  static const playStoreUrl =
      "https://play.google.com/store/apps/details?id=com.stepcountergpstracking";
  static const appleStoreUrl = "https://apps.apple.com/us/app/id6503128522";

  static String get privacyPolicyUrl => Platform.isAndroid
      ? "https://walnutsys.net/fitenss-privacy-policy/"
      : "https://thegifto.com/fitness-privacy-policy/";

  static String get termsOfServiceUrl => Platform.isAndroid
      ? "https://walnutsys.net/terms-of-use/"
      : "https://thegifto.com/terms-of-use/";

  static String get supportMail =>
      Platform.isAndroid ? "support@walnutsys.net" : "support@thegifto.com";
}
