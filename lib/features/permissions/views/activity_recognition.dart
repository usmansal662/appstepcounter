import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/permissions/controller.dart';
import 'package:step_counter/features/permissions/views/location.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/colors.dart';

class ActivityRecognitionPermissionView extends BaseView<PermissionController> {
  const ActivityRecognitionPermissionView({super.key});

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.1),
              Image.asset(
                walking,
                height: Get.height * 0.3,
              ),
              SizedBox(height: Get.height * 0.05),
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.activityRecognition),
                letterSpacing: 1,
              ),
              AppTexts.simpleText(
                text: controller.getLocale(LocaleKey.startTrackingYourSteps),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Get.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton.rectangularButton(
                    text: controller.getLocale(LocaleKey.notNow),
                    onClick: () => Get.to(() => const LocationPermissionView()),
                    width: Get.width * 0.4,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black54,
                    borderColor: Colors.black12,
                  ),
                  AppButton.rectangularButton(
                    text: controller.getLocale(LocaleKey.turnOn),
                    onClick: () async {
                      await Permission.activityRecognition.request();
                      await Permission.sensorsAlways.request();
                      Get.to(() => const LocationPermissionView());
                    },
                    width: Get.width * 0.4,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
