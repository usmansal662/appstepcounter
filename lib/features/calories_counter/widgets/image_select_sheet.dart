import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';

class ImageSelectSheet extends BaseWidget<CaloriesCounterController> {
  const ImageSelectSheet({super.key});

  @override
  Widget get child => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => controller.pickFoodImage(ImageSource.gallery),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.image_outlined, size: 100),
                  AppTexts.simpleText(
                    text: controller.getLocale(LocaleKey.gallery),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 17,
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () => controller.pickFoodImage(ImageSource.camera),
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.camera_alt_outlined, size: 100),
                  AppTexts.simpleText(
                    text: controller.getLocale(LocaleKey.camera),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 17,
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
