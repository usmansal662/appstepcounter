import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/circular_progress.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/workout/view.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:step_counter/utils/constants.dart';

import '../../../common_widgets/app_texts.dart';

class CaloriesCountScreen extends BaseView<CaloriesCounterController> {
  const CaloriesCountScreen({super.key});

  @override
  void initState(state) {
    super.initState(state);
    controller.countValues();
  }

  @override
  Widget? get body =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: Get.height * 0.2,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(foodDrink)),
                  ),
                ),
              ),
              AppButton.backButton,
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    graphs,
                    const SizedBox(height: 10),

                    //*
                    const Divider(
                      thickness: 5,
                      color: Colors.black,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.caloriesCount.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: AppTexts.simpleText(
                                  text:
                                  "${controller.getLocale(
                                      LocaleKey.total)} ${controller
                                      .caloriesCount[index].$4}",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: AppTexts.simpleText(
                                  text:
                                  " ${controller.caloriesCount[index]
                                      .$5} ${controller.caloriesCount[index]
                                      .$3}",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: AppTexts.simpleText(
                                  text:
                                  "${controller.caloriesCount[index].$2
                                      .toStringAsFixed(1)}%",
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                      separatorBuilder: (_, index) => const Divider(),
                    ),
                    const Divider(
                      thickness: 5,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );


  Widget get graphs =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: CircularProgress(
              strokeWidth: 15,
              aspectRatio: 1,
              foregroundColor: AppColors.primaryColor,
              progress: controller.calculateProgress(
                controller.countTotalCalories(),
                3000,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.electric_bolt_outlined,
                    color: Colors.red,
                  ),
                  AppTexts.simpleText(
                    text:
                    '${controller.countTotalCalories().toStringAsFixed(
                        1)} ${controller.getLocale(LocaleKey.kCal)}',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: List.generate(
                4,
                    (index) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: CircularProgress(
                              content: const SizedBox.shrink(),
                              foregroundColor: controller.caloriesCount[index]
                                  .$1,
                              aspectRatio: 2,
                              strokeWidth: 6,
                              progress: controller.caloriesCount[index].$2,
                            ),
                          ),
                          Expanded(
                            child: AppTexts.simpleText(
                              text:
                              "${controller.caloriesCount[index].$2
                                  .toStringAsFixed(1)}${controller
                                  .caloriesCount[index].$3}\n${controller
                                  .caloriesCount[index].$4}",
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
              ),
            ),
          )
        ],
      );

  @override
  Widget? get bottomNavBar =>
      Container(
        color: Colors.white,
        width: double.infinity,
        height: 70,
        alignment: Alignment.center,
        child: AppButton.rectangularButton(
          width: Get.width * 0.5,
          text: controller.getLocale(LocaleKey.burnNow),
          onClick: () =>
              Get.to(
                    () =>
                    WorkoutView(targetKCal: controller.countTotalCalories()),
              ),
        ),
      );
}
