import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _instance;

  static SharedPreferences get instance => _instance;

  // Initialize
  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
    Get.updateLocale(Locale(language));
  }

  /// Language
  static const String _kLanguageKey = "LANGUAGE_CODE_KEY";

  static set setLanguage(String value) =>
      _instance.setString(_kLanguageKey, value);

  static String get language => _instance.getString(_kLanguageKey) ?? 'en';

  /// Gender
  static const String _kGenderKey = "GENDER_KEY";

  static set setGender(String value) => _instance.setString(_kGenderKey, value);

  static String get gender => _instance.getString(_kGenderKey) ?? '';

  /// AGE
  static const String _kAgeKey = "AGE_KEY";

  static set setAge(String value) => _instance.setString(_kAgeKey, value);

  static String get age => _instance.getString(_kAgeKey) ?? '0';

  /// HEIGHT
  static const String _kHeightKey = "HEIGHT_KEY";

  static set setHeight(String value) => _instance.setString(_kHeightKey, value);

  static String get height => _instance.getString(_kHeightKey) ?? '0 Cm';

  /// WEIGHT
  static const String _kWeightKey = "WEIGHT_KEY";

  static set setWeight(String value) => _instance.setString(_kWeightKey, value);

  static String get weight => _instance.getString(_kWeightKey) ?? '0 Kg';

  /// App Open count
  static const String _kAppOpenCountKey = "APP_OPEN_COUNT_KEY";

  static void incrementAppCount() {
    int count = _instance.getInt(_kAppOpenCountKey) ?? 0;
    if (count == 3) {
      count = 0;
    }
    count++;
    _instance.setInt(_kAppOpenCountKey, count);
  }

  static int get appOpenCount => _instance.getInt(_kAppOpenCountKey) ?? 0;
}
