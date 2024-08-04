import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/get_started/controller.dart';
import 'package:step_counter/features/get_started/data/weight_enum.dart';
import 'package:step_counter/features/home/view.dart';
import 'package:step_counter/features/permissions/views/activity_recognition.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../common_widgets/app_button.dart';
import '../../../common_widgets/app_texts.dart';
import '../../../services/shared_preferences/app_preferences.dart';
import '../../../utils/colors.dart';
import '../../../utils/snack_bar.dart';
import '../widgets/stepper_widget.dart';

class WeightScreen extends BaseView<GetStartedController> {
  final bool isEdit;

  const WeightScreen({super.key, this.isEdit = false});

  @override
  Widget? get body => SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.2),
              const StepperWidget(currentStep: 3),
              SizedBox(height: Get.height * 0.1),
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.yourCurrentWeight),
                letterSpacing: 1,
              ),
              AppTexts.simpleText(
                text: controller.weight == Weight.kg
                    ? controller.getLocale(LocaleKey.weightInKgs)
                    : controller.getLocale(LocaleKey.weightInPounds),
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTexts.titleText(
                    text: controller.userWeight.toStringAsFixed(1),
                  ),
                  AppTexts.simpleText(
                      text: controller.getLocale(controller.weight.name)),
                ],
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: SfSliderTheme(
                  data: const SfSliderThemeData(
                    tickSize: Size(2.0, 35.0),
                    minorTickSize: Size(2.0, 15.0),
                  ),
                  child: SfSlider(
                    value: controller.userWeight,
                    min: 0,
                    max: controller.weight == Weight.lb ? 300 : 150,
                    onChanged: (value) => controller.updateWeightVal(value),
                    stepSize: 0.5,
                    showTicks: true,
                    showLabels: true,
                    interval: controller.weight == Weight.lb ? 35 : 17,
                    minorTicksPerInterval: 5,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  weightParamButton(weight: Weight.kg),
                  weightParamButton(weight: Weight.lb),
                ],
              ),
              SizedBox(height: Get.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton.rectangularButton(
                    text: controller.getLocale(LocaleKey.back),
                    onClick: Get.back,
                    width: Get.width * 0.4,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    borderColor: Colors.black38,
                  ),
                  AppButton.rectangularButton(
                    text: isEdit
                        ? controller.getLocale(LocaleKey.save)
                        : controller.getLocale(LocaleKey.next),
                    onClick: () {
                      if (controller.userWeight <= 0) {
                        showErrorSnackBar(
                          message:
                              controller.getLocale(LocaleKey.plzSelectWeight),
                        );
                      } else {
                        AppPreferences.setWeight =
                            "${controller.userWeight.toStringAsFixed(1)} ${controller.weight.name}";
                        if (isEdit) {
                          Get.back();
                        } else {
                          if (Platform.isAndroid) {
                            Get.offAll(
                              () => const ActivityRecognitionPermissionView(),
                            );
                          }
                          if (Platform.isIOS) {
                            Get.offAll(() => const HomeView());
                          }
                        }
                      }
                    },
                    width: Get.width * 0.4,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget weightParamButton({required Weight weight}) => InkWell(
        onTap: () => controller.updateWeight(weight),
        child: Container(
          height: 50,
          width: Get.width * 0.3,
          decoration: BoxDecoration(
            color: controller.weight == weight
                ? AppColors.primaryColor
                : Colors.white,
            borderRadius: weight == Weight.kg
                ? const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    bottomLeft: Radius.circular(32),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
            border: controller.weight != weight
                ? Border.all(color: Colors.black38, width: 1)
                : null,
          ),
          alignment: Alignment.center,
          child: AppTexts.simpleText(
            text: controller.getLocale(weight.name),
            color: controller.weight == weight
                ? AppColors.whiteColor
                : Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 18,
          ),
        ),
      );
}
