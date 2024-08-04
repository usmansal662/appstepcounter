import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_text_field.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/widgets/image_select_sheet.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';

class CreateOwnFoodScreen extends BaseView<CaloriesCounterController> {
  final String foodCategory;

  const CreateOwnFoodScreen({super.key, required this.foodCategory});

  @override
  void initState(state) {
    super.initState(state);
    controller.foodNameCtrl.clear();
    controller.netCarbsCtrl.clear();
    controller.caloriesCtrl.clear();
    controller.carbsCtrl.clear();
    controller.fatCtrl.clear();
    controller.proteinCtrl.clear();
    controller.potassiumCtrl.clear();
    controller.sodiumCtrl.clear();
    controller.cholesterolCtrl.clear();
    controller.fiberCtrl.clear();
    controller.image = null;
  }

  @override
  PreferredSizeWidget? get appBar => MyAppBar.settingsAppBar(
        title: controller.getLocale(LocaleKey.createYourFoodItem),
      );

  @override
  Widget? get body => SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts.titleText(
                  text: controller.getLocale(LocaleKey.foodDetails)),
              Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 20, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => Get.bottomSheet(
                          const ImageSelectSheet(),
                          backgroundColor: Colors.white,
                        ),
                        child: Container(
                          height: Get.height * 0.2,
                          width: Get.height * 0.3,
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.scaffoldColor,
                          ),
                          child: controller.image == null
                              ? const Icon(Icons.image, size: 70)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    controller.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      AppTextField.borderTextField(
                        controller: controller.foodNameCtrl,
                        hintText: controller.getLocale(LocaleKey.foodName),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //*
              AppTexts.titleText(
                  text: controller.getLocale(LocaleKey.servingSizeInfo)),
              Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 20, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField.borderNumField(
                        controller: controller.caloriesCtrl,
                        hintText: controller.getLocale(LocaleKey.calories),
                        suffixText: controller.getLocale(LocaleKey.kCal),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.carbsCtrl,
                              hintText: controller.getLocale(LocaleKey.carbs),
                              suffixText: controller.getLocale(LocaleKey.g),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.fatCtrl,
                              hintText: controller.getLocale(LocaleKey.fat),
                              suffixText: controller.getLocale(LocaleKey.g),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.proteinCtrl,
                              hintText: controller.getLocale(LocaleKey.protein),
                              suffixText: controller.getLocale(LocaleKey.g),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.potassiumCtrl,
                              hintText:
                                  controller.getLocale(LocaleKey.potassium),
                              suffixText: controller.getLocale(LocaleKey.mg),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.cholesterolCtrl,
                              hintText:
                                  controller.getLocale(LocaleKey.cholesterol),
                              suffixText: controller.getLocale(LocaleKey.mg),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.fiberCtrl,
                              hintText: controller.getLocale(LocaleKey.fiber),
                              suffixText: controller.getLocale(LocaleKey.g),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.netCarbsCtrl,
                              hintText:
                                  controller.getLocale(LocaleKey.netCarbs),
                              suffixText: controller.getLocale(LocaleKey.g),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppTextField.borderNumField(
                              controller: controller.sodiumCtrl,
                              hintText: controller.getLocale(LocaleKey.sodium),
                              suffixText: controller.getLocale(LocaleKey.mg),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              AppTexts.titleText(
                text: controller.getLocale(
                    LocaleKey.theNutritionValuesShouldBeApplyOnPerServing),
                textAlign: TextAlign.center,
                color: Colors.black54,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: AppButton.rectangularButton(
                  width: Get.width / 2,
                  text: controller.getLocale(LocaleKey.save),
                  onClick: () => controller.createUserFood(foodCategory),
                ),
              ),
            ],
          ),
        ),
      );
}
