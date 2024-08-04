import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/widgets/meal_view.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../common_widgets/app_button.dart';
import 'calories_food_sheet.dart';

class CaloriesFoodBottomNav extends BaseWidget<CaloriesCounterController> {
  const CaloriesFoodBottomNav({super.key});

  @override
  Widget get child => Container(
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          right: controller.isArabic ? 0 : 10,
          left: controller.isArabic ? 10 : 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Get.bottomSheet(
                const CaloriesFoodSheet(),
                backgroundColor: Colors.white,
              ),
              icon: const Icon(Icons.keyboard_arrow_up_outlined),
            ),
            SizedBox(
              width: Get.width - 160,
              height: 60,
              child: const MealView(maxLength: 5),
            ),
            AppButton.circularButton(
              height: 60,
              width: 100,
              fontSize: 14,
              text: controller.getLocale(LocaleKey.countCalories),
              onClick: controller.navigateToCountCalories,
            )
          ],
        ),
      );
}
