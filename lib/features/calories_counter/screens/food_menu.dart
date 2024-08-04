import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/features/calories_counter/model/food_cat_model.dart';
import 'package:step_counter/features/calories_counter/model/food_item.dart';
import 'package:step_counter/features/calories_counter/widgets/calories_food_bottom_nav.dart';
import 'package:step_counter/features/calories_counter/widgets/create_own_food_tile.dart';
import 'package:step_counter/features/calories_counter/widgets/delete_food_dialoge.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/cloud_firestore/food_repo.dart';
import 'package:step_counter/utils/colors.dart';

import '../../../services/shared_preferences/food_preferences.dart';
import 'food_detail.dart';

class FoodMenuScreen extends BaseView<CaloriesCounterController> {
  final FoodCategoryModel foodCategoryModel;

  const FoodMenuScreen({super.key, required this.foodCategoryModel});

  @override
  void initState(state) {
    super.initState(state);
    controller.userFood = FoodPreferences.getUserFood(foodCategoryModel.name);
  }

  @override
  PreferredSizeWidget? get appBar =>
      MyAppBar.regularAppBar(title: foodCategoryModel.name);

  @override
  Widget? get body => Column(
        children: [
          CachedNetworkImage(
            imageUrl: foodCategoryModel.image,
            imageBuilder: (_, image) => Container(
              height: Get.height * 0.2,
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              surfaceTintColor: Colors.white,
              color: Colors.white,
              child: TextFormField(
                controller: controller.searchCtrl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  hintText: controller.getLocale(LocaleKey.search),
                ),
                onChanged: (val) => controller.update(),
              ),
            ),
          ),
          CreateOwnFoodTile(foodCategory: foodCategoryModel.name),

          //*
          StreamBuilder<QuerySnapshot>(
              stream: FoodRepo.loadSubMenu(foodCategoryModel.name),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                      strokeWidth: 2.0,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                  return Center(
                    child: AppTexts.titleText(
                      text: controller.getLocale(LocaleKey.noDataFound),
                    ),
                  );
                } else {
                  List<DocumentSnapshot> foodCatList = snapshot.data.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          foodCatList.length + controller.userFood.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        if (index < controller.userFood.length) {
                          if (controller.searchCtrl.text.isEmpty) {
                            return tile(
                              controller.userFood[index],
                              true,
                              index,
                            );
                          } else if (controller.userFood[index].name
                              .toLowerCase()
                              .contains(
                                  controller.searchCtrl.text.toLowerCase())) {
                            return tile(
                              controller.userFood[index],
                              true,
                              index,
                            );
                          } else {
                            return const SizedBox();
                          }
                        } else {
                          int appFoodIndex = index - controller.userFood.length;
                          FoodItemModel itemModel = FoodItemModel.fromSnapshot(
                            foodCatList[appFoodIndex],
                          );
                          if (controller.searchCtrl.text.isEmpty) {
                            return tile(itemModel);
                          } else if (itemModel.name.toLowerCase().contains(
                              controller.searchCtrl.text.toLowerCase())) {
                            return tile(itemModel);
                          } else {
                            return const SizedBox();
                          }
                        }
                      },
                    ),
                  );
                }
              }),
        ],
      );

  @override
  Widget? get bottomNavBar =>
      controller.todayMeals.isEmpty ? null : const CaloriesFoodBottomNav();

  Widget tile(
    FoodItemModel itemModel, [
    bool canDelete = false,
    int index = -1,
  ]) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onLongPress: canDelete
              ? () {
                  Get.dialog(
                    DeleteFoodDialoge(
                      onDelete: () => controller.deleteUserFood(
                        index,
                        foodCategoryModel.name,
                      ),
                    ),
                  );
                }
              : null,
          onTap: () => Get.to(() => FoodDetailScreen(itemModel: itemModel)),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    AppTexts.titleText(
                      text: itemModel.name,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      textAlign: TextAlign.center,
                    ),
                    AppTexts.simpleText(
                      text:
                          "${controller.getLocale(LocaleKey.approx)} ${itemModel.calories} ${controller.getLocale(LocaleKey.kCalPerServing)}",
                      fontSize: 10,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: !itemModel.image.startsWith("http")
                    ? Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                            image: FileImage(File(itemModel.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: controller.isArabic
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: controller.isArabic
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  )
                                : const BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            controller.isMealExistInList(itemModel)
                                ? Icons.check_circle
                                : Icons.add_circle_outline_sharp,
                            color: controller.isMealExistInList(itemModel)
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: itemModel.image,
                        imageBuilder: (_, image) => Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: controller.isArabic
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            height: 50,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: controller.isArabic
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    )
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              controller.isMealExistInList(itemModel)
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline_sharp,
                              color: controller.isMealExistInList(itemModel)
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ),
                        errorWidget: (_, str, obj) => Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.black12,
                          ),
                          alignment: controller.isArabic
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            height: 50,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: controller.isArabic
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      bottomLeft: Radius.circular(16),
                                    )
                                  : const BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              controller.isMealExistInList(itemModel)
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline_sharp,
                              color: controller.isMealExistInList(itemModel)
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ),
                        placeholder: (_, str) => Shimmer.fromColors(
                          baseColor: AppColors.whiteColor,
                          highlightColor: AppColors.secondaryColor,
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      );

// ListTile(
//       onTap: () => Get.to(() => const SubMenuScreen()),
//       leading: CachedNetworkImage(
//         imageUrl: itemModel.image,
//         imageBuilder: (_, image) => CircleAvatar(
//           radius: 30,
//           backgroundImage: image,
//         ),
//         placeholder: (_, str) => Shimmer.fromColors(
//           baseColor: AppColors.whiteColor,
//           highlightColor: AppColors.secondaryColor,
//           child: const CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.black,
//           ),
//         ),
//       ),
//       title: AppTexts.titleText(
//         text: itemModel.name,
//         fontWeight: FontWeight.w600,
//         fontSize: 15,
//       ),
//       subtitle: AppTexts.simpleText(
//         text: "Approx ${itemModel.calories} Cal. per serving",
//         fontSize: 12,
//       ),
//       trailing: const IconButton(
//         onPressed: null,
//         icon: Icon(
//           Icons.add_circle_outline_sharp,
//           color: Colors.black,
//         ),
//       ),
//     );
}
