import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/weight_and_bmi/controller.dart';
import 'package:step_counter/features/weight_and_bmi/data/body_zone.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

class BodyZoneCard extends BaseWidget<WeightAndBMIController> {
  const BodyZoneCard({super.key});

  @override
  Widget get child => Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Align(
                alignment: controller.isArabic
                    ? Alignment.topLeft
                    : Alignment.topRight,
                child: AppTexts.titleText(
                  text: AppPreferences.weight,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 10),
              //*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  bodyZonesData.length,
                  (index) {
                    String bodyMassText = '';
                    if (index == 0) {
                      bodyMassText = '<${bodyZonesData[index].maxBodyMass}';
                    } else if (index + 1 == bodyZonesData.length) {
                      bodyMassText = '>${bodyZonesData[index].minBodyMass}';
                    } else {
                      bodyMassText =
                          '>${bodyZonesData[index].minBodyMass} <${bodyZonesData[index].maxBodyMass}';
                    }

                    return Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            controller.bodyMass == bodyZonesData[index].bodyMass
                                ? bodyZonesData[index].selectedImage
                                : bodyZonesData[index].image,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      child: AppTexts.simpleText(
                        text: bodyMassText,
                        fontSize: 12,
                        textAlign: TextAlign.right,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
}
