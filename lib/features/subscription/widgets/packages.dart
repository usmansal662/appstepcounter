import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/subscription/controller.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../localization/locale_keys.dart';
import '../../../utils/colors.dart';

class Packages extends BaseWidget<SubscriptionController> {
  const Packages({super.key});

  @override
  Widget get child => SizedBox(
        height: 180,
        child: Center(
          child: !controller.isStoreLoaded
              ? LoadingAnimationWidget.stretchedDots(
                  color: AppColors.primaryColor,
                  size: 50,
                )
              : controller.products.isEmpty
                  ? AppTexts.simpleText(
                      text: controller.getLocale(LocaleKey.noPackageFound),
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                      fontSize: 15,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => tile(index),
                      ),
                    ),
        ),
      );

  Widget tile(int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: InkWell(
          onTap: () => controller.updateSelectedPackage(index),
          child: Card(
            elevation: index == 1 ? 10 : 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: index == 1 ? 80 : 65,
                  width: Get.width * .28,
                  decoration: BoxDecoration(
                    color: index == 1
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: AppTexts.titleText(
                    text:
                        "${controller.getText(index)}\n${controller.products[index].price}",
                    fontWeight: FontWeight.w600,
                    color: index == 1 ? Colors.white : Colors.black,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: index == 1 ? 80 : 65,
                  width: Get.width * .28,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.brightness_1,
                        size: 10,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppTexts.simpleText(
                          text:
                              "${controller.getLocale(LocaleKey.billedEvery)} ${controller.getText(index)}",
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/*
*  Stack(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => tile(index),
                            ),
                          ),
                        ),
                        Center(
                          child: Card(
                            elevation: 10,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 80,
                                  width: Get.width * .32,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: AppTexts.titleText(
                                    text:
                                        "${controller.getText(1)}\n${controller.products[1].price}",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    textAlign: TextAlign.center,
                                    fontSize: 18,
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: Get.width * .32,
                                  decoration: const BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.brightness_1,
                                        size: 10,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: AppTexts.simpleText(
                                          text:
                                              "${controller.getLocale(LocaleKey.billedEvery)} ${controller.getText(1)}",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
* */
