import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/home/view.dart';
import 'package:step_counter/features/permissions/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../common_widgets/app_button.dart';
import '../../../common_widgets/app_texts.dart';

class SetupCompleteView extends BaseView<PermissionController> {
  const SetupCompleteView({super.key});

  @override
  Widget? get body => Container(
        width: double.infinity,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              check,
              height: Get.height * 0.2,
            ),
            SizedBox(height: Get.height * 0.05),
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.setupComplete),
              letterSpacing: 1,
            ),
            AppTexts.simpleText(
              text: controller.getLocale(LocaleKey.yourAppIsNowSetUp),
            ),
            SizedBox(height: Get.height * 0.1),
            AppButton.rectangularButton(
              text: controller.getLocale(LocaleKey.done),
              onClick: () => Get.offAll(() => const HomeView()),
              width: Get.width * 0.4,
            ),
          ],
        ),
      );
}
