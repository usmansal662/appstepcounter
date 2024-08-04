import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/permissions/controller.dart';
import 'package:step_counter/features/permissions/views/setup_complete.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/colors.dart';

class NotificationPermissionView extends BaseView<PermissionController> {
  const NotificationPermissionView({super.key});

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              notification,
              height: Get.height * 0.2,
            ),
            SizedBox(height: Get.height * 0.05),
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.turnOnNotification),
              letterSpacing: 1,
            ),
            AppTexts.simpleText(
              text: controller.getLocale(LocaleKey
                  .toReceiveStatusUpdatesWeNeedYourPermissionToShowYouNotification),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.05),
            Container(
              height: Get.height * 0.2,
              width: Get.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage(notificationBar),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppButton.rectangularButton(
                  text: controller.getLocale(LocaleKey.notNow),
                  onClick: () => Get.to(() => const SetupCompleteView()),
                  width: Get.width * 0.4,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black54,
                  borderColor: Colors.black12,
                ),
                AppButton.rectangularButton(
                  text: controller.getLocale(LocaleKey.turnOn),
                  onClick: () async {
                    await Permission.notification.request();
                    Get.to(() => const SetupCompleteView());
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
