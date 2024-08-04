import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/permissions/controller.dart';
import 'package:step_counter/features/permissions/views/notification.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../services/location/location_service.dart';
import '../../../utils/colors.dart';

class LocationPermissionView extends BaseView<PermissionController> {
  const LocationPermissionView({super.key});

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              pinLocation,
              height: Get.height * 0.2,
            ),
            SizedBox(height: Get.height * 0.05),
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.enableLocation),
              letterSpacing: 1,
            ),
            SizedBox(height: Get.height * 0.05),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text:
                        "\"${controller.getLocale(LocaleKey.enableLocation)}\" ",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                      text: controller.getLocale(LocaleKey
                          .toStartYourStepTrackingJourneyAndUnlockTheFullPotentialOfStepCounterGPSTracking)),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton.rectangularButton(
                  text: controller.getLocale(LocaleKey.notNow),
                  onClick: () =>
                      Get.to(() => const NotificationPermissionView()),
                  width: Get.width * 0.4,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black54,
                  borderColor: Colors.black12,
                ),
                AppButton.rectangularButton(
                  text: controller.getLocale(LocaleKey.turnOn),
                  onClick: () async {
                    await initializeLocationListener();
                    Get.to(() => const NotificationPermissionView());
                  },
                  width: Get.width * 0.4,
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      );
}
