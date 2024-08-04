import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/history/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/constants.dart';

class GridCards extends BaseWidget<HistoryController> {
  final int index;

  const GridCards({super.key, required this.index});

  @override
  Widget get child => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              smallCard(
                historyStep,
                controller.history[index].steps.toString(),
                controller.getLocale(LocaleKey.steps),
              ),
              smallCard(
                historyBurn,
                controller.history[index].caloriesBurn.toStringAsFixed(2),
                controller.getLocale(LocaleKey.kCal),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    historyDuration,
                    height: 40,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: AppTexts.simpleText(
                      text: controller.formatSeconds(index),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  AppTexts.simpleText(
                    text: controller.getLocale(LocaleKey.duration),
                    fontSize: 11,
                    color: Colors.black54,
                  )
                ],
              ),
            ),
          ),
        ],
      );

  Widget smallCard(String icon, String title, String subtitle) => SizedBox(
        width: Get.width * 0.4,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  height: 40,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTexts.simpleText(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    AppTexts.simpleText(
                      text: subtitle,
                      fontSize: 11,
                      color: Colors.black54,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
