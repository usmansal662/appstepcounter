import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_text_field.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/home/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/steps_preferences.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../utils/font_family.dart';

class StepGoalDialoge extends BaseWidget<HomeController> {
  const StepGoalDialoge({super.key});

  @override
  Widget get child => AlertDialog(
        backgroundColor: AppColors.whiteColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.cancel),
                ),
                const SizedBox(width: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(shoe),
                    AppTexts.titleText(text: "Step goal"),
                  ],
                ),
                const Spacer(),
              ],
            ),

            //*
            GestureDetector(
              onTap: () => controller.updateDialogeValue(!controller.isDialoge),
              child: SizedBox(
                height: controller.isDialoge ? 170 : 100,
                child: controller.isDialoge
                    ? CupertinoPicker(
                        diameterRatio: 5,
                        itemExtent: 60,
                        scrollController: FixedExtentScrollController(
                          initialItem: StepsPreferences.goalStep == 0
                              ? 10000
                              : StepsPreferences.goalStep,
                        ),
                        looping: true,
                        onSelectedItemChanged: (index) {
                          controller.updateStepsGoal(index);
                        },
                        children: List.generate(
                          50000,
                          (index) => AppTexts.titleText(
                            text: index.toString(),
                            fontSize: 30,
                          ),
                        ),
                      )
                    : Center(
                        child: AppTextField.noneBorderNumField(
                          controller: controller.stepsGoalCtrl,
                          onChange: (val) => val.isEmpty
                              ? controller.updateStepsGoal(0)
                              : controller.updateStepsGoal(int.parse(val)),
                          align: TextAlign.center,
                          focus: true,
                          style: const TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.poppin,
                            fontSize: 30,
                          ),
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 10),

            //*
            AppButton.rectangularButton(
              width: Get.width / 2,
              text: controller.getLocale(LocaleKey.save),
              onClick: controller.saveGoalSteps,
            ),
            const SizedBox(height: 10),
            AppButton.rectangularButton(
              width: Get.width / 2,
              text: controller.getLocale(LocaleKey.cancel),
              onClick: () {
                Get.back();
                controller.updateDialogeValue(true);
              },
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
              borderColor: Colors.black12,
            ),
          ],
        ),
      );
}
