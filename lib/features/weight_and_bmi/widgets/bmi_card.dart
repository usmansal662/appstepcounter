import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/get_started/screens/height.dart';
import 'package:step_counter/features/get_started/screens/weight.dart';
import 'package:step_counter/features/weight_and_bmi/controller.dart';
import 'package:step_counter/features/weight_and_bmi/data/bmi_index.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/utils/constants.dart';

class BMICard extends BaseWidget<WeightAndBMIController> {
  const BMICard({super.key});

  @override
  Widget get child => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          healthCard,

          //*
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const HeightScreen(isEdit: true))
                      ?.then((value) => controller.calculateBMI()),
                  child: measureCard(
                    image: bmiHeight,
                    text: controller.getLocale(LocaleKey.height),
                    value: AppPreferences.height,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(() => const WeightScreen(isEdit: true))
                      ?.then((value) => controller.calculateBMI()),
                  child: measureCard(
                    image: bmiWeight,
                    text: controller.getLocale(LocaleKey.weight),
                    value: AppPreferences.weight,
                  ),
                ),
              ),
            ],
          )
        ],
      );

  Widget get healthCard => Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppTexts.titleText(text: controller.bmi.toStringAsFixed(1)),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: controller.bmi.cardColor,
                      // const Color(0xffD5FFD8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: controller.bmi.textColor,
                        width: .5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: AppTexts.simpleText(
                      text: controller.getLocale(controller.bmi.healthStatus),
                      color: controller.bmi.textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              //*
              Container(
                height: 20,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff43A5FF),
                      Color(0xff60FFEE),
                      Color(0xffFFD435),
                      Color(0xffFF0B3C),
                    ],
                  ),
                ),
              ),

              //*
              Row(
                children: List.generate(
                  bmiIndex.length,
                  (index) => Expanded(
                    child: AppTexts.simpleText(
                      text: bmiIndex[index].toString(),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget measureCard({
    required String image,
    required String text,
    required String value,
  }) =>
      Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: SizedBox(
          height: 90,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    image,
                    height: 30,
                    width: 30,
                  ),
                  Image.asset(
                    scale,
                    width: 100,
                    height: 50,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppTexts.simpleText(
                    text: text,
                    fontWeight: FontWeight.w900,
                  ),
                  AppTexts.simpleText(
                    text: value,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
