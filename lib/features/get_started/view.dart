import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:step_counter/utils/constants.dart';

import 'controller.dart';

class GetStartedView extends BaseView<GetStartedController> {
  final Widget nextPage;

  const GetStartedView({super.key, required this.nextPage});

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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: (Get.width / 2) - 120),
                    child: Image.asset(
                      dots,
                      height: 10,
                    ),
                  ),
                ),
                AppTexts.titleText(
                  text: controller.getLocale(LocaleKey.stepCounter),
                  color: Colors.white,
                  fontSize: 30,
                ),
                AppTexts.titleText(
                  text: controller.getLocale(LocaleKey.gpsTracking),
                  color: Colors.white,
                  fontSize: 30,
                ),
                AppTexts.simpleText(
                  text: controller.getLocale(LocaleKey.newDayFreshStart),
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                AppTexts.simpleText(
                  text: controller.getLocale(LocaleKey.stepIntoWellness),
                  color: Colors.white,
                  textAlign: TextAlign.center,
                  fontSize: 22,
                ),
                AppTexts.simpleText(
                  text: controller
                      .getLocale(LocaleKey.trackStepsBurnCaloriesLiveHealthier),
                  color: Colors.white,
                  textAlign: TextAlign.center,
                ),
                Image.asset(
                  personWalking,
                  color: Colors.white,
                ),
                AppButton.rectangularButton(
                  text: controller.getLocale(LocaleKey.getStarted),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  onClick: () => Get.offAll(() => nextPage),
                ),
                const SizedBox(height: 10),
                AppTexts.simpleText(
                  text: controller.getLocale(
                    LocaleKey
                        .toEnsureStepCounterGPSTrackingFunctionsWellWeNeedYourPermissionToAccessActivityRecognition,
                  ),
                  textAlign: TextAlign.center,
                  color: Colors.white,
                  fontSize: 12,
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ],
      );
}
