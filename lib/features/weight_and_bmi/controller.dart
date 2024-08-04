import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/features/weight_and_bmi/data/body_zone.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

import '../../services/google_mobile_ads/ad_helper.dart';

class WeightAndBMIController extends BaseController {
  static final instance = Get.find<WeightAndBMIController>();

  ///*
  BodyMass bodyMass = BodyMass.normal;
  double bmi = 0;

  void calculateBMI() {
    double height = getHeightInMeters(AppPreferences.height);
    double weight = getWeightInKg(AppPreferences.weight);
    /*
    UNDERWEIGHT: BMI less than 18.5
    NORMAL: BMI 18.5 to 24.9
    OVERWEIGHT: BMI 25 to 29.9
    OBESE: BMI 30 to 34.9
    EXTREMELY OBESE: BMI 35 and above
    * */
    debugPrint("Height in m: $height");
    debugPrint("Weight in Kg: $weight");
    bmi = weight / (height * height);
    debugPrint("BMI: $bmi");
    if (bmi <= 18.5) {
      bodyMass = BodyMass.underweight;
    } else if (bmi > 18.5 && bmi <= 24.9) {
      bodyMass = BodyMass.normal;
    } else if (bmi > 24.9 && bmi <= 29.9) {
      bodyMass = BodyMass.overweight;
    } else if (bmi > 29.9 && bmi <= 34.9) {
      bodyMass = BodyMass.obese;
    } else if (bmi > 34.9) {
      bodyMass = BodyMass.extremelyObese;
    }
    update();
  }

  ///* Banner Ad
  BannerAd? bannerAd;

  Future<void> loadAndShowBannerAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      Get.width.truncate(),
    );

    if (size == null) {
      debugPrint('Unable to get size of banner.');
      return;
    }
    BannerAd(
      adUnitId: AdHelper.weightAndBMIBannerAdId,
      size: size,
      request: const AdRequest(extras: {"collapsible": "bottom"}),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('Home Banner Ad Loaded');
          bannerAd = ad as BannerAd;
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint("Home Banner Ad Failed to load $error");
          ad.dispose();
          bannerAd = null;
          update();
        },
      ),
    ).load();
  }
}
