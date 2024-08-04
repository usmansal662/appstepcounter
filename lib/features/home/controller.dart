import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pedometer/pedometer.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/services/shared_preferences/steps_preferences.dart';

import '../../common_widgets/ad_load_dialoge.dart';
import '../../services/google_mobile_ads/ad_helper.dart';

class HomeController extends BaseController {
  static final instance = Get.find<HomeController>();
  FlutterBackgroundService backgroundService = FlutterBackgroundService();
  bool isWalking = false;
  StreamSubscription? subscription;

  DateTime focusDay = DateTime.now();

  updateFocusDay(DateTime value) {
    focusDay = value;
    update();
  }

  int walkingSeconds = StepsPreferences.walkingSeconds;

  @override
  void onInit() {
    super.onInit();
    Stream.periodic(const Duration(seconds: 1)).listen((event) {
      updateActivityCard();
    });

    /// Walking Status
    Pedometer.pedestrianStatusStream.listen((event) {
      if (event.status.toLowerCase() == 'walking') {
        isWalking = true;
        update();
        debugPrint("Walking Status: ${event.status}");
        if (subscription == null) {
          subscription =
              Stream.periodic(const Duration(seconds: 1)).listen((event) {
            walkingSeconds++;
            StepsPreferences.setWalkingSecs = walkingSeconds;
          });
        } else {
          subscription?.resume();
        }
      } else {
        isWalking = false;
        update();
        subscription?.pause();
      }
    }).onError((error) {});
  }

  //*
  double kCal = 0;
  double km = 0;
  int min = 0;
  int steps = 0;

  void updateActivityCard() async {
    await AppPreferences.instance.reload();

    if (Platform.isAndroid || Platform.isIOS) {
      steps = StepsPreferences.todaySteps;
      min = StepsPreferences.walkingSeconds ~/ 60;
    }
    // if (Platform.isIOS) {
    //   steps = (walkingSeconds * 1.4).round();
    //   min = walkingSeconds ~/ 60;
    //   StepsPreferences.setTodayStep = steps;
    //   if (steps >= stepsGoal &&
    //       stepsGoal != 0 &&
    //       !StepsPreferences.notificationValue) {
    //     showNotification(
    //       title: "Hurrah! 🎊🎉",
    //       body: "You have completed your steps goal today.",
    //     );
    //     StepsPreferences.toggleNotification = true;
    //   }
    // }

    (double, double) distanceAndCalories =
        calculateDistanceAndCalories(StepsPreferences.walkingSeconds, steps);
    km = distanceAndCalories.$1;
    kCal = distanceAndCalories.$2;
    update();
  }

  //*
  int stepsGoal = 1000;

  void updateStepsGoal(int value) {
    stepsGoal = value;
    stepsGoalCtrl.text = value.toString();
    update();
  }

  //*
  bool isDialoge = true;
  TextEditingController stepsGoalCtrl = TextEditingController(
    text: StepsPreferences.goalStep.toString(),
  );

  void updateDialogeValue(bool value) {
    isDialoge = value;
    update();
  }

  //*
  void saveGoalSteps() {
    if (GlobalController.instance.interstitialAd != null && !isSubscribed) {
      Get.dialog(const AdLoadDialoge(), barrierDismissible: false);
      Future.delayed(const Duration(seconds: 1), () {
        Get.back(); // Close Load Internet Dialoge
        GlobalController.instance.interstitialAd?.show();
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back(); // Close Step Goal Dialoge
          StepsPreferences.setGoalStep = stepsGoal;
          isDialoge = true;
          update();
        });
      });
    } else {
      Get.back(); // Close Step Goal Dialoge
      StepsPreferences.setGoalStep = stepsGoal;
      isDialoge = true;
      update();
    }
    StepsPreferences.toggleNotification = false;
    // toggleBackgroundService();
  }

  /// Toggle Steps Counter Pause /Play
  // bool isEnableStepCounter = false;
  //
  // void toggleStepsCounter() {
  //   isEnableStepCounter = !isEnableStepCounter;
  //   StepsPreferences.toggleSteps = isEnableStepCounter;
  //   update();
  //
  //   //*
  //   toggleBackgroundService();
  // }

  // void toggleBackgroundService() {
  //   backgroundService.invoke("stopService");
  //   Future.delayed(const Duration(seconds: 1), () {
  //     backgroundService.startService();
  //   });
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    final TrackingStatus status =
        await AppTrackingTransparency.trackingAuthorizationStatus;

    // If the system can show an authorization request dialog
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint("UUID: $uuid");
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
      adUnitId: AdHelper.homeBannerAdId,
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
