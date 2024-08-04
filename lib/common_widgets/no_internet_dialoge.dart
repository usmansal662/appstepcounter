import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/home/view.dart';

import '../core/global/global_controller.dart';
import '../localization/locale_keys.dart';
import '../utils/colors.dart';
import 'app_button.dart';
import 'app_texts.dart';

class NoInternetDialoge extends BaseWidget<GlobalController> {
  const NoInternetDialoge({super.key});

  @override
  Widget get child => AlertDialog(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Row(
          children: [
            const Icon(Icons.warning),
            const SizedBox(width: 20),
            Expanded(
              child: AppTexts.titleText(
                text: controller.getLocale(LocaleKey.noInternet),
              ),
            ),
          ],
        ),
        content: AppTexts.simpleText(
          text: controller.getLocale(
            LocaleKey.checkYourInternetConnection,
          ),
          textAlign: TextAlign.justify,
        ),
        actions: [
          AppButton.rectangularButton(
            width: 100,
            height: 40,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            borderColor: Colors.black,
            text: controller.getLocale(LocaleKey.exit),
            onClick: () => Get.offAll(() => const HomeView()),
          ),
          AppButton.rectangularButton(
            width: 100,
            height: 40,
            text: controller.getLocale(LocaleKey.refresh),
            onClick: () => AppSettings.openAppSettings(
              type: AppSettingsType.wifi,
            ),
          ),
        ],
      );
}
