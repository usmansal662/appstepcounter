import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/common_widgets/no_internet_dialoge.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/screens/food_menu.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../utils/colors.dart';

class CaloriesCounterView extends BaseView<CaloriesCounterController> {
  const CaloriesCounterView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    if (controller.bannerAd == null && !controller.isSubscribed) {
      controller.loadAndShowBannerAd();
    }

    controller.searchCtrl.clear(); // reset the text controller
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!GlobalController.instance.isInternetAvailable) {
        Get.dialog(const NoInternetDialoge(), barrierDismissible: false);
      } else if (controller.foodCategories.isEmpty) {
        controller.loadFoods();
      } else {
        controller.filterList = List.from(controller.foodCategories);
        controller.filterList.shuffle();
      }
    });
  }

  @override
  void disposeState(state) {
    super.disposeState(state);
    controller.bannerAd?.dispose();
    controller.bannerAd = null;
  }

  @override
  bool get isLoading => controller.isLoading;

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(
        title: controller.getLocale(LocaleKey.caloriesCounter),
      );

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*
            Card(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              child: TextFormField(
                controller: controller.searchCtrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  hintText: controller.getLocale(LocaleKey.search),
                ),
                onChanged: (val) => controller.filterResult(val),
              ),
            ),

            const SizedBox(height: 10),

            //*
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.addTodayMeal),
            ),
            AppTexts.simpleText(
              text: controller
                  .getLocale(LocaleKey.trackDailyCaloriesBySelectingMeals),
            ),

            const SizedBox(height: 10),

            //*
            controller.filterList.isEmpty
                ? Center(
                    child: AppTexts.titleText(
                      text: controller.getLocale(LocaleKey.noDataFound),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        // mainAxisSpacing: 40,
                      ),
                      itemCount: controller.filterList.length,
                      itemBuilder: (_, index) => Center(
                        child: InkWell(
                          onTap: () => Get.to(
                            () => FoodMenuScreen(
                              foodCategoryModel: controller.filterList[index],
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: controller.filterList[index].image,
                            imageBuilder: (_, image) => Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: image,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                bottomText(controller.filterList[index].name),
                              ],
                            ),
                            errorWidget: (_, str, obj) => Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  height: 140,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                      Icons.image_not_supported_outlined),
                                ),
                                bottomText(controller.filterList[index].name),
                              ],
                            ),
                            placeholder: (_, str) => Shimmer.fromColors(
                              baseColor: AppColors.whiteColor,
                              highlightColor: AppColors.secondaryColor,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                  ),
                                  bottomText(controller.filterList[index].name),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      );

  @override
  Widget? get bottomNavBar =>
      controller.bannerAd != null && !controller.isSubscribed
          ? Container(
              color: Colors.black45,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: controller.bannerAd?.size.height.toDouble(),
                    child: AdWidget(ad: controller.bannerAd!),
                  ),
                ],
              ),
            )
          : null;

  Positioned bottomText(String text) => Positioned(
        bottom: -20,
        child: Container(
          width: Get.width * 0.5 - Get.width * 0.05 - 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
          ),
          padding: const EdgeInsets.all(8),
          child: AppTexts.simpleText(
            text: text,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
