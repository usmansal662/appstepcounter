import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/workout/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

class FinishWorkoutDialoge extends BaseWidget<WorkoutController> {
  const FinishWorkoutDialoge({super.key});

  @override
  Widget get child => AlertDialog(
        backgroundColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        content: AppTexts.simpleText(
          text: controller.getLocale(LocaleKey.doYouWannaFinishAndSave),
          fontWeight: FontWeight.bold,
        ),
        actions: [
          AppButton.rectangularButton(
            width: Get.width * 0.3,
            height: 40,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black54,
            borderColor: Colors.black12,
            text: controller.getLocale(LocaleKey.cancel),
            onClick: () {
              Get.back();
              controller.resumeTimer();
            },
          ),
          AppButton.rectangularButton(
            width: Get.width * 0.3,
            height: 40,
            text: controller.getLocale(LocaleKey.finish),
            onClick: controller.finishWorkout,
          )
        ],
      );
}
