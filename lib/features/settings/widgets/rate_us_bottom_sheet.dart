import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/settings/controller.dart';
import 'package:step_counter/features/settings/data/rate_us.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:step_counter/utils/constants.dart';

class RateUsBottomSheet extends BaseWidget<SettingsController> {
  const RateUsBottomSheet({super.key});

  @override
  Widget get child => Container(
        height: Get.height * 0.6,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(rateSheet),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -70,
              right: Get.width * 0.5 - 100,
              child: Image.asset(
                rateUsData[controller.rating].emoji,
                height: 200,
                width: 200,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppTexts.titleText(
                    text: controller.getLocale(
                      rateUsData[controller.rating].title,
                    ),
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                  AppTexts.simpleText(
                    text: controller.getLocale(
                      rateUsData[controller.rating].subtitle,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      5,
                      (index) => InkWell(
                        onTap: () => controller.updateRate(index + 1),
                        child: Icon(
                          index < controller.rating
                              ? Icons.star
                              : Icons.star_border,
                          size: 40,
                          color: index < controller.rating
                              ? Colors.amber
                              : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  AppButton.rectangularButton(
                    backgroundColor: controller.rating <= 0
                        ? AppColors.primaryColor.withOpacity(0.4)
                        : AppColors.primaryColor,
                    text: controller.getLocale(LocaleKey.rateUs),
                    onClick:
                        controller.rating <= 0 ? null : controller.submitRating,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
