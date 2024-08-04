import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onepref/onepref.dart';
import 'package:step_counter/features/get_started/data/gender_enum.dart';

import '../../../localization/ar.dart';
import '../../../localization/en.dart';
import '../../../localization/es.dart';
import '../../../localization/fr.dart';
import '../../../localization/pt.dart';
import '../../../services/shared_preferences/app_preferences.dart';

abstract class BaseController extends GetxController {
  /// User Subscription Flag
  bool get isSubscribed => OnePref.getRemoveAds() ?? false;

  /// Localization
  dynamic setLocal(String str) {
    Get.back();
    Get.updateLocale(Locale(str));
    AppPreferences.setLanguage = str;
    update();
  }

  String getLocale(localeKey) {
    String translation = "$localeKey not found";
    switch (AppPreferences.language) {
      case 'en':
        if (englishLocalization.containsKey(localeKey)) {
          translation = englishLocalization[localeKey];
        }
        break;
      case 'ar':
        if (arabicLocalization.containsKey(localeKey)) {
          translation = arabicLocalization[localeKey];
        }
        break;
      case 'pt':
        if (portugueseLocalization.containsKey(localeKey)) {
          translation = portugueseLocalization[localeKey];
        }
        break;
      case 'es':
        if (spanishLocalization.containsKey(localeKey)) {
          translation = spanishLocalization[localeKey];
        }
        break;
      case 'fr':
        if (frenchLocalization.containsKey(localeKey)) {
          translation = frenchLocalization[localeKey];
        }
        break;
    }
    return translation;
  }

  bool get isEng => AppPreferences.language == 'en';

  bool get isArabic => AppPreferences.language == 'ar';

  bool get isPortuguese => AppPreferences.language == 'pt';

  bool get isSpanish => AppPreferences.language == 'es';

  bool get isFrench => AppPreferences.language == 'fr';

  (double, double) calculateDistanceAndCalories(int seconds, int steps) {
    double weight = getWeightInKg(AppPreferences.weight);
    double height = getHeightInMeters(AppPreferences.height) * 100;
    double age = double.parse(AppPreferences.age);

    double metWalking = 3.5;

    double distanceMeters = steps * 0.75; // Average step length in meters=0.75
    double distanceKm = distanceMeters / 1000;

    // BMR (Basal Metabolic Rate) in kcal/day using Mifflin St Jeor equation
    double bmr = 0;
    if (AppPreferences.gender.gender == Gender.male) {
      // For Men:
      // BMR = 10 * weight (in kg) + 6.25 * height (in cm) - 5 * age (in years) + 5

      bmr = 10 * weight + 6.25 * height * 100 - 5 * age + 5;
    }
    if (AppPreferences.gender.gender == Gender.female) {
      // For Women:
      // BMR = 10 * weight (in kg) + 6.25 * height (in cm) - 5 * age (in years) - 161
      bmr = 10 * weight + 6.25 * height * 100 - 5 * age - 161;
    }

    // Calories burned in kcal
    double caloriesBurned = bmr * metWalking * distanceKm / weight;
    double kCal = caloriesBurned / 1000;

    return (distanceKm, kCal);
  }

  double getWeightInKg(String weightStr) {
    double weight;
    if (weightStr.endsWith('Kg')) {
      final split = weightStr.split(' ');
      weight = double.parse(split.first);
    } else {
      final split = weightStr.split(' ');
      weight = double.parse(split.first) * 0.45359237;
    }
    return weight;
  }

  double getHeightInMeters(String heightStr) {
    double height;
    if (heightStr.endsWith('Cm')) {
      final split = heightStr.split(' ');
      height = double.parse(split.first) / 100;
    } else {
      final split = heightStr.split(' ');
      height = double.parse(split.first) * 0.3048;
    }
    return height;
  }

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
