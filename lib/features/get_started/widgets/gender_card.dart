import 'package:flutter/material.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';

import '../../../common_widgets/app_texts.dart';
import '../controller.dart';
import '../data/gender_enum.dart';

class GenderCard extends BaseWidget<GetStartedController> {
  final String selectedGenderImage;
  final String genderImage;
  final Gender gender;
  final String genderText;

  const GenderCard({
    super.key,
    required this.selectedGenderImage,
    required this.gender,
    required this.genderImage,
    required this.genderText,
  });

  @override
  Widget get child => InkWell(
        onTap: () => controller.updateGender(gender),
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  controller.gender == gender
                      ? selectedGenderImage
                      : genderImage,
                ),
                const SizedBox(height: 10),
                AppTexts.simpleText(
                  text: genderText,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      );
}
