import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/splash/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../common_widgets/app_texts.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class SplashView extends BaseView<SplashController> {
  const SplashView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    if (!controller.isSubscribed) {
      controller.loadAndShowSplashInterstitialAd();
    } else {
      Future.delayed(const Duration(seconds: 4), () {
        controller.navigateToNextScreen();
      });
    }

    Future.delayed(const Duration(seconds: 6), () {
      controller.updateNetworkValue(true);
    });
  }

  @override
  Widget? get body => Stack(
        children: [
          Image.asset(
            splashShoes,
            fit: BoxFit.cover,
          ),
          Container(
            height: Get.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppTexts.titleText(
                  text: controller.getLocale(LocaleKey.stepCounterGPSTracking),
                  color: Colors.white,
                ),
                AppTexts.simpleText(
                  text: controller.getLocale(LocaleKey.newDayFreshStart),
                  color: Colors.white,
                ),
                SizedBox(height: Get.height * 0.05),
                LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: !controller.isSubscribed,
                  child: AppTexts.simpleText(
                    text: controller.getLocale(LocaleKey.loadingAd),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: controller.isNetworkSlow,
                  child: AppTexts.simpleText(
                    text: controller.getLocale(
                      LocaleKey.checkYourInternetConnection,
                    ),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * 0.08),
                AppTexts.titleText(
                  text: controller
                      .getLocale(LocaleKey.tieYourShoesItTimeToStepIntoAction),
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  letterSpacing: 1,
                ),
                SizedBox(height: Get.height * 0.05),
              ],
            ),
          ),
        ],
      );
}
