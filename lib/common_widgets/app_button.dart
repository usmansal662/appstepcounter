import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';

class AppButton {
  static Widget rectangularButton({
    required String text,
    required VoidCallback? onClick,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? height,
    double? width,
  }) =>
      InkWell(
        onTap: onClick,
        child: Container(
          height: height ?? 50,
          width: width ?? Get.width * 0.7,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: borderColor == null
                ? null
                : Border.all(color: borderColor, width: 1),
          ),
          alignment: Alignment.center,
          child: AppTexts.simpleText(
            text: text,
            color: foregroundColor ?? AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 18,
          ),
        ),
      );

  static Widget circularButton({
    required String text,
    required VoidCallback onClick,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    double? height,
    double? width,
    double? fontSize,
  }) =>
      InkWell(
        onTap: onClick,
        child: Container(
          height: height ?? 50,
          width: width ?? Get.width * 0.7,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(36),
            border: borderColor == null
                ? null
                : Border.all(color: borderColor, width: 1),
          ),
          alignment: Alignment.center,
          child: AppTexts.simpleText(
            text: text,
            color: foregroundColor ?? AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: fontSize ?? 18,
            textAlign: TextAlign.center,
          ),
        ),
      );

  static Widget startWorkout({required VoidCallback onClick}) => InkWell(
        onTap: onClick,
        child: Container(
          height: 70,
          color: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: AppTexts.titleText(
            text: GlobalController.instance.getLocale(LocaleKey.startWorkout),
            color: Colors.white,
          ),
        ),
      );

  static Widget get backButton => Positioned(
        top: 30,
        left: GlobalController.instance.isArabic ? Get.width - 60 : 10,
        child: IconButton.filled(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      );
}
