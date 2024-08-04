import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

class DeleteFoodDialoge extends BaseWidget<CaloriesCounterController> {
  final VoidCallback onDelete;

  const DeleteFoodDialoge({
    super.key,
    required this.onDelete,
  });

  @override
  Widget get child => AlertDialog(
        backgroundColor: Colors.white,
        title:
            AppTexts.titleText(text: controller.getLocale(LocaleKey.warning)),
        content: AppTexts.simpleText(
            text: controller.getLocale(LocaleKey.areYouSureToDeleteThisItem)),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: AppTexts.titleText(
              text: controller.getLocale(LocaleKey.cancel),
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: onDelete,
            child: AppTexts.titleText(
              text: controller.getLocale(LocaleKey.delete),
              color: Colors.red,
              fontSize: 18,
            ),
          ),
        ],
      );
}
