import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/widgets/delete_food_dialoge.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../utils/colors.dart';

class CaloriesFoodSheet extends BaseWidget<CaloriesCounterController> {
  const CaloriesFoodSheet({super.key});

  @override
  Widget get child => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: List.generate(
            controller.todayMeals.length,
            (index) => ListTile(
              onTap: () {
                Get.dialog(
                  DeleteFoodDialoge(
                    onDelete: () => controller.removeTodayMeal(index),
                  ),
                );
              },
              leading:
                  controller.todayMeals[index].foodItem.image.startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: controller.todayMeals[index].foodItem.image,
                          imageBuilder: (_, image) => CircleAvatar(
                            radius: 30,
                            backgroundImage: image,
                          ),
                          placeholder: (_, str) => Shimmer.fromColors(
                            baseColor: AppColors.whiteColor,
                            highlightColor: AppColors.secondaryColor,
                            child: const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(
                            File(controller.todayMeals[index].foodItem.image),
                          ),
                        ),

//       const CircleAvatar(backgroundImage: AssetImage(burger)),
              title: AppTexts.titleText(
                text: controller.todayMeals[index].foodItem.name,
                fontSize: 15,
              ),
              subtitle: AppTexts.simpleText(
                text:
                    "${controller.todayMeals[index].foodItem.calories} ${controller.getLocale(LocaleKey.kCalPerServing)}. x ${controller.todayMeals[index].amount} = ${controller.todayMeals[index].foodItem.calories * controller.todayMeals[index].amount} ${controller.getLocale(LocaleKey.kCal)}",
                fontSize: 11,
              ),
              trailing: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ),
        ),
      );
}
