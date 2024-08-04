import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../../common_widgets/app_texts.dart';

class AmountToEat extends BaseWidget<CaloriesCounterController> {
  const AmountToEat({super.key});

  @override
  Widget get child => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTexts.simpleText(
            text: controller.getLocale(LocaleKey.amountToEat),
            fontWeight: FontWeight.bold,
          ),
          Container(
            height: 30,
            width: 110,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: controller.decrementQuantity,
                  icon: const Icon(
                    CupertinoIcons.minus,
                    color: Colors.black,
                    size: 14,
                  ),
                ),
                AppTexts.simpleText(
                  text: controller.quantity.toString(),
                  fontSize: 12,
                ),
                IconButton(
                  onPressed: controller.incrementQuantity,
                  icon: const Icon(
                    CupertinoIcons.add,
                    color: Colors.black,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
