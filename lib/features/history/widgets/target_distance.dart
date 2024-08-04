import 'package:flutter/material.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/history/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/constants.dart';

class TargetDistance extends BaseWidget<HistoryController> {
  final int index;

  const TargetDistance({super.key, required this.index});

  @override
  Widget get child => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.titleText(
                  text:
                      "${controller.history[index].distance.toStringAsFixed(2)} ${controller.getLocale(LocaleKey.km)}",
                ),
                AppTexts.simpleText(
                  text: controller.getLocale(LocaleKey.targetDistance),
                  fontSize: 10,
                ),
              ],
            ),
            Image.asset(
              run,
              height: 50,
            ),
          ],
        ),
      );
}
