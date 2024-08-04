import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/settings/controller.dart';
import 'package:step_counter/features/subscription/view.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../utils/constants.dart';

class PremiumBox extends BaseWidget<SettingsController> {
  const PremiumBox({super.key});

  @override
  Widget get child => InkWell(
        onTap: () => Get.to(() => const SubscriptionView()),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: const DecorationImage(
              image: AssetImage(premium),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                pro,
                height: 100,
                width: 100,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTexts.titleText(
                      text: controller.getLocale(LocaleKey.goPremium),
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                    AppTexts.simpleText(
                        text: controller.getLocale(LocaleKey.unlockAllFeatures),
                        color: Colors.white,
                        textAlign: TextAlign.center),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
