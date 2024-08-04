import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/features/home/controller.dart';
import 'package:step_counter/features/home/widgets/step_goal_dialoge.dart';
import 'package:step_counter/services/google_mobile_ads/ad_helper.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../localization/locale_keys.dart';

class SetGoalCard extends BaseWidget<HomeController> {
  const SetGoalCard({super.key});

  @override
  Widget get child => Container(
        height: 120,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: AssetImage(goalBox),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.setDailyGoal),
              color: Colors.white,
            ),
            AppTexts.simpleText(
              text:
                  controller.getLocale(LocaleKey.ourInspiredToBetterThemselves),
              color: Colors.white,
              fontSize: 10,
            ),
            Align(
              alignment:
                  controller.isArabic ? Alignment.topLeft : Alignment.topRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  if (GlobalController.instance.interstitialAd == null &&
                      !controller.isSubscribed) {
                    GlobalController.instance.loadInterstitialAd(
                      AdHelper.saveStepGoalInterstitialAdId,
                    );
                  }
                  Get.dialog(const StepGoalDialoge());
                },
                child: AppTexts.simpleText(
                  text: controller.getLocale(LocaleKey.setNow),
                ),
              ),
            )
          ],
        ),
      );
}
