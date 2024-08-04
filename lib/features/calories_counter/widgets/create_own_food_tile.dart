import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/screens/create_own_food.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../common_widgets/app_texts.dart';

class CreateOwnFoodTile extends BaseWidget<CaloriesCounterController> {
  final String foodCategory;

  const CreateOwnFoodTile({super.key, required this.foodCategory});

  @override
  Widget get child => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: InkWell(
          onTap: () => Get.to(
            () => CreateOwnFoodScreen(foodCategory: foodCategory),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.add_circle_outline_sharp),
              const SizedBox(width: 10),
              Expanded(
                child: Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTexts.simpleText(
                          text:
                              controller.getLocale(LocaleKey.createYourOwnFood),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
