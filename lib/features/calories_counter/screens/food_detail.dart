import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/data/size.dart';
import 'package:step_counter/features/calories_counter/model/food_item.dart';
import 'package:step_counter/features/calories_counter/model/today_meal_model.dart';
import 'package:step_counter/features/calories_counter/widgets/amount_to_eat.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class FoodDetailScreen extends BaseView<CaloriesCounterController> {
  final FoodItemModel itemModel;

  const FoodDetailScreen({super.key, required this.itemModel});

  @override
  void initState(state) {
    super.initState(state);
    controller.quantity = 1;
    controller.sizeEnum = SizeEnum.small;
    controller.isShowChart = false;
    controller.updateNutritionInfo(itemModel);
  }

  @override
  Widget? get body => Column(
        children: [
          Stack(
            children: [
              !itemModel.image.startsWith("http")
                  ? Container(
                      height: Get.height * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(itemModel.image)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: itemModel.image,
                      imageBuilder: (_, image) => Container(
                        height: Get.height * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (_, str) => Shimmer.fromColors(
                        baseColor: AppColors.scaffoldColor,
                        highlightColor: AppColors.secondaryColor,
                        child: Container(
                          height: 200,
                          color: Colors.black,
                        ),
                      ),
                    ),
              AppButton.backButton,
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: AppTexts.titleText(text: itemModel.name),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.titleText(
                      text: controller.getLocale(LocaleKey.detail),
                      fontSize: 15,
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const AmountToEat(),
                            const SizedBox(height: 30),
                            AppButton.rectangularButton(
                              text: controller
                                  .getLocale(LocaleKey.addInTodayMeal),
                              height: 40,
                              onClick: () => controller.addTodayMeal(
                                TodayMealModel(
                                  amount: controller.quantity,
                                  foodItem: itemModel,
                                ),
                              ),
                            ),
                            // AppTexts.simpleText(
                            //   text: "Choose the burger size",
                            //   fontWeight: FontWeight.bold,
                            // ),
                            // const SizedBox(height: 10),
                            // ...List.generate(
                            //   sizeData.length,
                            //   (index) => radio(
                            //     title: sizeData[index].$1,
                            //     size: sizeData[index].$2,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppTexts.titleText(
                      text: controller
                          .getLocale(LocaleKey.nutritionInfoPerServing),
                      fontSize: 15,
                    ),
                    Card(
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: controller.isShowChart
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SfCircularChart(
                                    tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                    margin: const EdgeInsets.all(0),
                                    legend: const Legend(isVisible: true),
                                    series: <CircularSeries>[
                                      PieSeries<FoodDetailsChartData, String>(
                                        dataSource: [
                                          FoodDetailsChartData(
                                            controller
                                                .getLocale(LocaleKey.carbs),
                                            itemModel.carbs.toDouble(),
                                          ),
                                          FoodDetailsChartData(
                                            controller.getLocale(LocaleKey.fat),
                                            itemModel.fat.toDouble(),
                                          ),
                                          FoodDetailsChartData(
                                            controller
                                                .getLocale(LocaleKey.protein),
                                            itemModel.protein.toDouble(),
                                          ),
                                          FoodDetailsChartData(
                                            controller
                                                .getLocale(LocaleKey.fiber),
                                            itemModel.fiber.toDouble(),
                                          ),
                                          FoodDetailsChartData(
                                            controller
                                                .getLocale(LocaleKey.netCarbs),
                                            itemModel.netCarbs.toDouble(),
                                          ),
                                          FoodDetailsChartData(
                                            controller
                                                .getLocale(LocaleKey.sodium),
                                            itemModel.sodium.toDouble() / 1000,
                                          ),
                                          FoodDetailsChartData(
                                            controller
                                                .getLocale(LocaleKey.potassium),
                                            itemModel.potassium.toDouble() /
                                                1000,
                                          ),
                                          FoodDetailsChartData(
                                            controller.getLocale(
                                                LocaleKey.cholesterol),
                                            itemModel.cholesterol.toDouble() /
                                                1000,
                                          ),
                                        ],
                                        xValueMapper:
                                            (FoodDetailsChartData data, _) =>
                                                data.x,
                                        yValueMapper:
                                            (FoodDetailsChartData data, _) =>
                                                data.y,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true),
                                      )
                                    ],
                                  ),
                                  ...List.generate(
                                    controller.nutritionInfo.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppTexts.simpleText(
                                            text: controller
                                                .nutritionInfo[index].$1,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                          AppTexts.simpleText(
                                            text: controller
                                                .nutritionInfo[index].$2,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : ListTile(
                                onTap: () => controller.updateShowChart(true),
                                leading: Image.asset(chart),
                                title: AppTexts.titleText(
                                  text:
                                      "${controller.getLocale(LocaleKey.approx)} ${itemModel.calories} ${controller.getLocale(LocaleKey.kCal)}",
                                  fontSize: 15,
                                ),
                                subtitle: AppTexts.simpleText(
                                  text: controller.nutritionText,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );

// Widget radio({required String title, required SizeEnum size}) =>
//     RadioMenuButton(
//       value: size,
//       groupValue: controller.sizeEnum,
//       onChanged: (val) => val != null ? controller.updateSize(val) : null,
//       child: AppTexts.simpleText(text: title),
//     );
}

class FoodDetailsChartData {
  FoodDetailsChartData(this.x, this.y);

  final String x;
  final double y;
}
