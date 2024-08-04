import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/get_started/controller.dart';
import 'package:step_counter/features/get_started/data/gender_enum.dart';
import 'package:step_counter/features/get_started/screens/age.dart';
import 'package:step_counter/features/get_started/widgets/gender_card.dart';
import 'package:step_counter/features/get_started/widgets/stepper_widget.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:step_counter/utils/constants.dart';
import 'package:step_counter/utils/snack_bar.dart';

class SelectGenderScreen extends BaseView<GetStartedController> {
  const SelectGenderScreen({super.key});

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const StepperWidget(currentStep: 0),
            SizedBox(height: Get.height * 0.1),
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.selectGender),
              letterSpacing: 1,
            ),
            AppTexts.simpleText(
              text: controller
                  .getLocale(LocaleKey.caloriesStrideLengthCalculationNeedsIt),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderCard(
                  selectedGenderImage: selectedMale,
                  gender: Gender.male,
                  genderImage: male,
                  genderText: controller.getLocale(LocaleKey.male),
                ),
                GenderCard(
                  selectedGenderImage: selectedFemale,
                  gender: Gender.female,
                  genderImage: female,
                  genderText: controller.getLocale(LocaleKey.female),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.04),
            AppButton.rectangularButton(
              text: controller.getLocale(LocaleKey.contnue),
              backgroundColor: controller.gender == Gender.none
                  ? AppColors.primaryColor.withOpacity(0.3)
                  : AppColors.primaryColor,
              onClick: () {
                if (controller.gender == Gender.none) {
                  showErrorSnackBar(
                    message:
                        controller.getLocale(LocaleKey.pleaseSelectTheGender),
                  );
                } else {
                  AppPreferences.setGender = controller.gender.name;
                  Get.to(() => const AgeScreen());
                }
              },
            ),
            AppTexts.simpleText(
              text: controller.getLocale(LocaleKey.pleaseFillRealData),
              color: Colors.black45,
            )
          ],
        ),
      );
}
