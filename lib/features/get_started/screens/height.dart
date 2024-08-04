import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/get_started/controller.dart';
import 'package:step_counter/features/get_started/screens/weight.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../common_widgets/app_button.dart';
import '../../../common_widgets/app_texts.dart';
import '../../../services/shared_preferences/app_preferences.dart';
import '../../../utils/colors.dart';
import '../../../utils/snack_bar.dart';
import '../data/height_enum.dart';
import '../widgets/stepper_widget.dart';

class HeightScreen extends BaseView<GetStartedController> {
  final bool isEdit;

  const HeightScreen({super.key, this.isEdit = false});

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
              Visibility(
                visible: !isEdit,
                child: const StepperWidget(currentStep: 2),
              ),
              SizedBox(height: Get.height * 0.1),
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.howTallAreYou),
                letterSpacing: 1,
              ),
              AppTexts.simpleText(
                text: controller.height == Height.cm
                    ? controller.getLocale(LocaleKey.heightInCms)
                    : controller.getLocale(LocaleKey.heightInFts),
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTexts.titleText(
                    text: controller.userHeight.toStringAsFixed(1),
                  ),
                  AppTexts.simpleText(
                      text: controller.getLocale(controller.height.name)),
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
                    value: controller.userHeight,
                    min: 0,
                    max: controller.height == Height.ft ? 15 : 250,
                    onChanged: (value) => controller.updateHeightVal(value),
                    stepSize: 0.1,
                    showTicks: true,
                    showLabels: true,
                    interval: controller.height == Height.ft ? 1 : 25,
                    minorTicksPerInterval: 5,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  heightParamButton(height: Height.cm),
                  heightParamButton(height: Height.ft),
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
                      if (controller.userHeight <= 0) {
                        showErrorSnackBar(
                          message:
                              controller.getLocale(LocaleKey.plzSelectHeight),
                        );
                      } else {
                        AppPreferences.setHeight =
                            "${controller.userHeight.toStringAsFixed(1)} ${controller.height.name}";
                        if (isEdit) {
                          Get.back();
                        } else {
                          Get.to(() => const WeightScreen());
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

  Widget heightParamButton({required Height height}) => InkWell(
        onTap: () => controller.updateHeight(height),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Container(
            height: 50,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              color: controller.height == height
                  ? AppColors.primaryColor
                  : Colors.white,
              borderRadius: height == Height.cm
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
              border: controller.height != height
                  ? Border.all(color: Colors.black38, width: 1)
                  : null,
            ),
            alignment: Alignment.center,
            child: AppTexts.simpleText(
              text: controller.getLocale(height.name),
              color: controller.height == height
                  ? AppColors.whiteColor
                  : Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              fontSize: 18,
            ),
          ),
        ),
      );
}
