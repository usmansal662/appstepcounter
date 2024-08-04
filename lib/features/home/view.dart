import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/gps_tracking/view.dart';
import 'package:step_counter/features/home/controller.dart';
import 'package:step_counter/features/home/widgets/activity_card.dart';
import 'package:step_counter/features/home/widgets/calendar_card.dart';
import 'package:step_counter/features/home/widgets/set_goal_card.dart';
import 'package:step_counter/features/subscription/view.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/location/location_service.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

import '../../services/background/background_service.dart';
import '../../utils/constants.dart';
import '../calories_counter/view.dart';
import '../trends_and_insights/view.dart';
import '../weight_and_bmi/view.dart';
import '../workout/view.dart';
import 'widgets/health_tracker_card.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  void initState(state) async {
    super.initState(state);

    if (controller.bannerAd == null && !controller.isSubscribed) {
      controller.loadAndShowBannerAd();
    }

    //*
    // controller.isEnableStepCounter = StepsPreferences.isEnableSteps;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.to(() => const SubscriptionView());
    });

    /// Tracking Transparency (IOS)
    if (Platform.isIOS) {
      await controller.initPlugin();
    }

    /// Initialize Background Service
    if (await Permission.activityRecognition.status ==
        PermissionStatus.granted) {
      await initializeBackgroundService();
    } else {
      final status = await Permission.activityRecognition.request();
      if (status == PermissionStatus.granted) {
        await initializeBackgroundService();
      }
    }

    /// Initialize Location Listener permission
    await initializeLocationListener();
  }

  @override
  void disposeState(state) {
    super.disposeState(state);
    controller.bannerAd?.dispose();
    controller.bannerAd = null;
  }

  @override
  PreferredSizeWidget? get appBar => MyAppBar.homeAppBar;

  @override
  Widget? get body => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*
              const CalendarCard(),

              //*
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.activities),
                fontSize: 17,
                color: Colors.black54,
              ),
              const ActivityCard(),

              //*
              const SetGoalCard(),

              //*
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.healthTracker),
                fontSize: 17,
                color: Colors.black54,
              ),
              InkWell(
                onTap: () => Get.to(() => const TrendsAndInsightsView()),
                child: const HealthTrackerCard(
                  image: trends,
                  title: LocaleKey.trendsInsights,
                  subtitle: LocaleKey.navigateYourPath,
                ),
              ),
              InkWell(
                onTap: () => Get.to(() => const WeightAndBMIView()),
                child: const HealthTrackerCard(
                  image: bmi,
                  title: LocaleKey.weightBMI,
                  subtitle: LocaleKey.cultivateWellnessTrackWeightMeasureHealth,
                ),
              ),
              InkWell(
                onTap: () => Get.to(() => const GPSTrackingView()),
                child: const HealthTrackerCard(
                  image: gps,
                  title: LocaleKey.gpsTracking,
                  subtitle: LocaleKey.trackStepsBurnCaloriesMeasureDistance,
                ),
              ),
              InkWell(
                onTap: () => Get.to(() => const CaloriesCounterView()),
                child: const HealthTrackerCard(
                  image: calories,
                  title: LocaleKey.caloriesCounter,
                  subtitle:
                      LocaleKey.trackYourIntakeMonitorCaloriesStayBalanced,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget? get bottomNavBar =>
      controller.bannerAd != null && !controller.isSubscribed
          ? Container(
              color: Colors.black45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton.startWorkout(
                    onClick: () => Get.to(() => const WorkoutView()),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: controller.bannerAd?.size.height.toDouble(),
                    child: AdWidget(ad: controller.bannerAd!),
                  ),
                ],
              ),
            )
          : AppButton.startWorkout(
              onClick: () => Get.to(() => const WorkoutView()),
            );
}
