import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../core/base/widget/base_widget.dart';
import '../../../localization/locale_keys.dart';
import '../../../services/url_launcher/url_launch_service.dart';
import '../controller.dart';

class CheckUpdateDialoge extends BaseWidget<SettingsController> {
  const CheckUpdateDialoge({super.key});

  @override
  Widget get child => AlertDialog(
        backgroundColor: AppColors.scaffoldColor,
        title: Row(
          children: [
            Image.asset(
              appIcon,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: AppTexts.titleText(
                text: controller.getLocale(LocaleKey.stepCounterGPSTracking),
              ),
            ),
          ],
        ),
        content: AppTexts.simpleText(
          text: controller.getLocale(LocaleKey.checkUpdateDesc),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: AppTexts.simpleText(
              text: controller.getLocale(LocaleKey.cancel),
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Platform.isAndroid
                  ? UrlLaunchService.instance.launchPlayStore()
                  : UrlLaunchService.instance.launchAppleStore();
            },
            child: AppTexts.simpleText(
              text: controller.getLocale(LocaleKey.check),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
