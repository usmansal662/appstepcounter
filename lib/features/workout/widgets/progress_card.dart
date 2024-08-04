import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/widgets/meal_view.dart';
import 'package:step_counter/features/workout/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/constants.dart';

class ProgressCardWidget extends BaseWidget<WorkoutController> {
  final double? targetKCal;

  const ProgressCardWidget({super.key, required this.targetKCal});

  @override
  Widget get child => Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              targetKCal != null &&
                      CaloriesCounterController.instance.todayMeals.isNotEmpty
                  ? SizedBox(
                      height: 70,
                      width: Get.width,
                      child: MealView(maxLength: Get.width ~/ 45),
                    )
                  : const SizedBox.shrink(),
              targetKCal != null
                  ? controller.cal < targetKCal!
                      ? AppTexts.simpleText(
                          text:
                              "${controller.getLocale(LocaleKey.targetCaloriesToBurn)} 🔥 ${(targetKCal! - controller.cal).toStringAsFixed(1)}${controller.getLocale(LocaleKey.kCal)}",
                        )
                      : AppTexts.simpleText(
                          text: controller.getLocale(
                              LocaleKey.hurrahYouHitTheTargetCaloriesBurn),
                          textAlign: TextAlign.center,
                        )
                  : const SizedBox.shrink(),

              //*
              Directionality(
                textDirection: TextDirection.ltr,
                child: AppTexts.titleText(
                  text:
                      "${controller.hour.toString().padLeft(2, '0')}:${controller.min.toString().padLeft(2, '0')}:${controller.sec.toString().padLeft(2, '0')}",
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                ),
              ),

              //*
              AppTexts.simpleText(
                text: controller.getLocale(LocaleKey.duration),
                fontSize: 14,
                color: Colors.black45,
              ),

              const SizedBox(height: 10),
              //*
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF3F4F9),
                  borderRadius: BorderRadius.circular(24),
                ),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    activityInfo(
                      image: activityCalories,
                      text:
                          "${controller.cal.toStringAsFixed(1)}${controller.getLocale(LocaleKey.kCal)}",
                    ),
                    activityInfo(
                      image: step,
                      text:
                          "${controller.steps}${controller.getLocale(LocaleKey.steps)}",
                    ),
                    activityInfo(
                      image: activityPin,
                      text:
                          "${controller.km.toStringAsFixed(2)}${controller.getLocale(LocaleKey.km)}",
                    ),
                    // activityInfo(image: activityTime, text: "0min"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget activityInfo({required String image, required String text}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            image,
            height: 15,
            width: 15,
          ),
          const SizedBox(width: 4),
          AppTexts.simpleText(text: text, fontSize: 12),
        ],
      );
}
