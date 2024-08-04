import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/features/settings/view.dart';
import 'package:step_counter/features/subscription/view.dart';
import 'package:step_counter/localization/locale_keys.dart';

import 'app_texts.dart';

class MyAppBar {
  static PreferredSizeWidget get homeAppBar => AppBar(
        leading: IconButton(
          onPressed: () => Get.to(() => const SubscriptionView()),
          icon: const Icon(
            Icons.diamond_outlined,
            color: Color(0xffC88F0C),
          ),
        ),
        title: AppTexts.titleText(
          text: GlobalController.instance.getLocale(LocaleKey.home),
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const SettingsView()),
            icon: const Icon(
              Icons.settings,
              color: Colors.black87,
            ),
          ),
        ],
      );

  static PreferredSizeWidget regularAppBar({
    required String title,
    VoidCallback? onClick,
  }) =>
      AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: onClick ?? Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        title: AppTexts.titleText(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const SubscriptionView()),
            icon: const Icon(
              Icons.diamond_outlined,
              color: Color(0xffC88F0C),
            ),
          ),
          IconButton(
            onPressed: () => Get.to(() => const SettingsView()),
            icon: const Icon(
              Icons.settings,
              color: Colors.black87,
            ),
          ),
        ],
      );

  static PreferredSizeWidget settingsAppBar({required String title}) => AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
        ),
        title: AppTexts.titleText(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      );
}
