import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/core/global/global_controller.dart';

import '../../services/google_mobile_ads/ad_helper.dart';
import '../../services/shared_preferences/app_preferences.dart';
import '../get_started/screens/age.dart';
import '../get_started/screens/height.dart';
import '../get_started/screens/select_gender.dart';
import '../get_started/screens/weight.dart';
import '../get_started/view.dart';
import '../home/view.dart';
import '../permissions/views/activity_recognition.dart';
import '../permissions/views/location.dart';
import '../permissions/views/notification.dart';

class SplashController extends BaseController {
  static final instance = Get.find<SplashController>();
  bool isNetworkSlow = false;

  void updateNetworkValue(bool value) {
    isNetworkSlow = value;
    update();
  }

  /// Load And Show Interstitial Ad
  bool isShownAd = false;
  bool isNavigated = false;

  Future<void> loadAndShowSplashInterstitialAd() async {
    Future.delayed(const Duration(seconds: 10), () {
      if (!isShownAd) {
        navigateToNextScreen();
        isNavigated = true;
      }
    });

    //*
    await InterstitialAd.load(
      adUnitId: AdHelper.splashInterstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        //*
        onAdLoaded: (InterstitialAd ad) {
          debugPrint("ad Loaded");

          //*
          if (isNavigated) {
            GlobalController.instance.interstitialAd ??= ad;
          } else {
            ad.show();
          }
          isShownAd = true;

          //*
          Future.delayed(const Duration(milliseconds: 200), () {
            navigateToNextScreen();
          });

          //*
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (err) {
          debugPrint("ad failed Loaded");
          navigateToNextScreen();
        },
      ),
    );
  }

  Future<void> navigateToNextScreen() async {
    Widget nextScreen;
    if (AppPreferences.gender.isEmpty) {
      nextScreen = const SelectGenderScreen();
    } else if (AppPreferences.age == '0') {
      nextScreen = const AgeScreen();
    } else if (AppPreferences.height == '0 Cm') {
      nextScreen = const HeightScreen();
    } else if (AppPreferences.weight == '0 Kg') {
      nextScreen = const WeightScreen();
    } else if (!await Permission.activityRecognition.isGranted &&
        Platform.isAndroid) {
      nextScreen = const ActivityRecognitionPermissionView();
    } else if (await Location().hasPermission() != PermissionStatus.granted &&
        Platform.isAndroid) {
      nextScreen = const LocationPermissionView();
    } else if (!await Permission.notification.isGranted && Platform.isAndroid) {
      nextScreen = const NotificationPermissionView();
    } else {
      nextScreen = const HomeView();
    }
    Get.offAll(() => GetStartedView(nextPage: nextScreen));
  }
}
