import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/get_started/controller.dart';
import 'package:step_counter/features/get_started/screens/height.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../services/shared_preferences/app_preferences.dart';
import '../../../utils/snack_bar.dart';
import '../widgets/stepper_widget.dart';

class AgeScreen extends BaseView<GetStartedController> {
  const AgeScreen({super.key});

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
              const StepperWidget(currentStep: 1),
              SizedBox(height: Get.height * 0.1),
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.whatYourAge),
                letterSpacing: 1,
              ),
              AppTexts.simpleText(
                text: controller.getLocale(LocaleKey.ageInYears),
              ),
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTexts.titleText(
                    text: controller.userAge.toStringAsFixed(1),
                  ),
                  AppTexts.simpleText(
                    text: controller.getLocale(LocaleKey.year),
                  ),
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
                    value: controller.userAge,
                    min: 0,
                    max: 100,
                    onChanged: (value) => controller.updateAge(value),
                    stepSize: 0.1,
                    showTicks: true,
                    showLabels: true,
                    interval: 10,
                    minorTicksPerInterval: 5,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.1),
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
                    text: controller.getLocale(LocaleKey.next),
                    onClick: () {
                      if (controller.userAge <= 0) {
                        showErrorSnackBar(
                          message:
                              controller.getLocale(LocaleKey.plzSelectYourAge),
                        );
                      } else {
                        AppPreferences.setAge =
                            controller.userAge.toStringAsFixed(1);
                        Get.to(() => const HeightScreen());
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
}
