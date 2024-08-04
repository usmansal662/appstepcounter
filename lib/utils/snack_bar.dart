import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/app_texts.dart';
import 'colors.dart';

showSuccessSnackBar({required String message}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.secondaryColor,
      content: AppTexts.simpleText(
        text: message,
        textAlign: TextAlign.center,
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}

showErrorSnackBar({required String message}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: AppTexts.simpleText(
        text: message,
        textAlign: TextAlign.center,
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ),
  );
}

showNoInternet() {}
