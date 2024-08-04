import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/colors.dart';
import 'calories_food_sheet.dart';

class MealView extends BaseWidget<CaloriesCounterController> {
  final int maxLength;

  const MealView({super.key, required this.maxLength});

  @override
  Widget get child => InkWell(
        onTap: () => Get.bottomSheet(
          const CaloriesFoodSheet(),
          backgroundColor: Colors.white,
        ),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(
              controller.todayMeals.length > maxLength
                  ? maxLength
                  : controller.todayMeals.length,
              (index) => Positioned(
                left: index * 40,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: index + 1 == maxLength &&
                          controller.todayMeals.length > maxLength
                      ? BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(-2, 1),
                              color: AppColors.primaryColor.withOpacity(0.4),
                            ),
                          ],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        )
                      : BoxDecoration(
                          color: Colors.white,
                          image: controller.todayMeals[index].foodItem.image
                                  .startsWith('http')
                              ? DecorationImage(
                                  image: NetworkImage(
                                    controller.todayMeals[index].foodItem.image,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: FileImage(File(controller
                                      .todayMeals[index].foodItem.image)),
                                  fit: BoxFit.cover,
                                ),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(-2, 1),
                              color: AppColors.primaryColor.withOpacity(0.4),
                            )
                          ],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                        ),
                  alignment: Alignment.center,
                  child: index + 1 == maxLength &&
                          controller.todayMeals.length > maxLength
                      ? AppTexts.simpleText(
                          text:
                              '+${controller.todayMeals.length - (maxLength - 1)}',
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
      );
}
