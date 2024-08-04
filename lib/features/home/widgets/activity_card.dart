import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/home/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/steps_preferences.dart';
import 'package:step_counter/utils/constants.dart';

import '../../history/view.dart';

class ActivityCard extends BaseWidget<HomeController> {
  const ActivityCard({super.key});

  @override
  Widget get child => Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.history, color: Colors.transparent,
                      // controller.isEnableStepCounter
                      //     ? Icons.pause_circle
                      //     : Icons.play_circle,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        controller.isWalking ? personWalking : personStand,
                        color: Colors.black,
                        height: 50,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                      AppTexts.titleText(
                        text: controller.steps.toString(),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Get.to(() => const HistoryView()),
                    icon: const Icon(Icons.history, color: Colors.black54),
                  ),
                ],
              ),

              //*
              AppTexts.simpleText(
                text:
                    "(${controller.getLocale(LocaleKey.goal)}: ${StepsPreferences.goalStep}) ${controller.getLocale(LocaleKey.steps)}",
                fontSize: 10,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    activityInfo(
                      image: activityCalories,
                      text:
                          "${controller.kCal.toStringAsFixed(2)}${controller.getLocale(LocaleKey.kCal)}",
                    ),
                    activityInfo(
                      image: activityPin,
                      text:
                          "${controller.km.toStringAsFixed(2)}${controller.getLocale(LocaleKey.km)}",
                    ),
                    activityInfo(
                      image: activityTime,
                      text:
                          "${controller.min}${controller.getLocale(LocaleKey.min)}",
                    ),
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
          AppTexts.simpleText(text: text, fontSize: 12),
        ],
      );
}
