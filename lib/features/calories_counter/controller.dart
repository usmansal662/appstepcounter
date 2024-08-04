import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_counter/common_widgets/ad_load_dialoge.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/features/calories_counter/data/size.dart';
import 'package:step_counter/features/calories_counter/model/food_item.dart';
import 'package:step_counter/features/calories_counter/model/today_meal_model.dart';
import 'package:step_counter/services/cloud_firestore/food_repo.dart';
import 'package:step_counter/services/pick_image/image.dart';
import 'package:step_counter/services/shared_preferences/food_preferences.dart';

import 'package:step_counter/utils/snack_bar.dart';

import '../../core/global/global_controller.dart';
import '../../localization/locale_keys.dart';
import '../../services/google_mobile_ads/ad_helper.dart';
import 'model/food_cat_model.dart';
import 'screens/calories_count.dart';

class CaloriesCounterController extends BaseController {
  static final instance = Get.find<CaloriesCounterController>();
  List<FoodCategoryModel> foodCategories=[];
  bool isLoading=false;

  @override
  void onInit() {
    super.onInit();
    loadFoods();
  }

  //*
  Future<void> loadFoods()async{
    isLoading=true;
    update();

    //*
    List<DocumentSnapshot> docs=await FoodRepo.loadFoodCategory();
    foodCategories.clear();
    for(DocumentSnapshot doc in docs){
      foodCategories.add(FoodCategoryModel.fromSnapshot(doc));
      update();
    }
    filterList = List.from(foodCategories);
    filterList.shuffle();

    //*
    isLoading=false;
    update();
  }

  //*
  TextEditingController searchCtrl = TextEditingController();
  List<FoodCategoryModel> filterList=[];
  void filterResult(String value){
    filterList.clear();
    if(value.isEmpty){
      filterList=List.from(foodCategories);
    }else{
      for(FoodCategoryModel model in foodCategories){
        if(model.name.toLowerCase().contains(value.toLowerCase())){
          filterList.add(model);
        }
      }
    }
    update();
  }


  File? image;
  void pickFoodImage(ImageSource source)async{
    Get.back();
    final result=await PickImage.pickImage(source: source);
    image=result;
    update();
  }
  TextEditingController foodNameCtrl = TextEditingController();
  TextEditingController caloriesCtrl = TextEditingController();
  TextEditingController carbsCtrl = TextEditingController();
  TextEditingController fatCtrl = TextEditingController();
  TextEditingController proteinCtrl = TextEditingController();
  TextEditingController fiberCtrl = TextEditingController();
  TextEditingController netCarbsCtrl = TextEditingController();
  TextEditingController potassiumCtrl = TextEditingController();
  TextEditingController sodiumCtrl = TextEditingController();
  TextEditingController cholesterolCtrl = TextEditingController();

  List<FoodItemModel> userFood=[];
  void createUserFood(String categoryName){
    if(image==null){
      showErrorSnackBar(message: getLocale(LocaleKey.pleaseSelectTheImage));
    }else if(foodNameCtrl.text.isEmpty){
      showErrorSnackBar(message: getLocale(LocaleKey.pleaseFillTheFoodNameField));
    }else if(caloriesCtrl.text.isEmpty){
      showErrorSnackBar(message: getLocale(LocaleKey.pleaseFillTheCalories));
    }else{
      FoodItemModel model=FoodItemModel(
        name: foodNameCtrl.text,
        calories: int.parse(caloriesCtrl.text),
        image: image!.path,
        carbs: carbsCtrl.text.isEmpty ? 0 : int.parse(carbsCtrl.text),
        fat: fatCtrl.text.isEmpty ? 0 : int.parse(fatCtrl.text),
        protein: proteinCtrl.text.isEmpty ? 0 : int.parse(proteinCtrl.text),
        fiber: fiberCtrl.text.isEmpty ? 0 : int.parse(fiberCtrl.text),
        netCarbs: netCarbsCtrl.text.isEmpty ? 0 : int.parse(netCarbsCtrl.text),
        sodium: sodiumCtrl.text.isEmpty ? 0 : int.parse(sodiumCtrl.text),
        potassium: potassiumCtrl.text.isEmpty ? 0 : int.parse(potassiumCtrl.text),
        cholesterol: cholesterolCtrl.text.isEmpty ? 0 : int.parse(cholesterolCtrl.text),
      );
      FoodPreferences.addFood(model: model, key: categoryName);
      userFood.insert(0, model);
      Get.back();
      showSuccessSnackBar(message: "${model.name} ${getLocale(LocaleKey.addedIn)} $categoryName");
      update();
    }
  }

  void deleteUserFood(int index, String foodCat){
    Get.back();
    FoodPreferences.removeFood(index: index, key:foodCat);
    showSuccessSnackBar(message: "${getLocale(LocaleKey.successfullyRemoved)} ${userFood[index].name}");
    userFood.removeAt(index);
    update();
  }


  //
  int quantity = 1;

  void decrementQuantity() {
    if(quantity>0){
      quantity--;
      update();
    }
  }

  void incrementQuantity() {
    quantity++;
    update();
  }

  //*
  SizeEnum sizeEnum = SizeEnum.small;

  void updateSize(SizeEnum value) {
    sizeEnum = value;
    update();
  }

  //
  bool isShowChart = false;

  updateShowChart(bool value) {
    isShowChart = value;
    update();
  }

  //* Nutrition Info
  List<(String, String)> nutritionInfo = [];
  String nutritionText='';

  void updateNutritionInfo(FoodItemModel model) {
    nutritionInfo = [
      ( getLocale(LocaleKey.calories), "${getLocale(LocaleKey.approx)} ${model.calories}"),
      (getLocale(LocaleKey.carbs), "${getLocale(LocaleKey.approx)} ${model.carbs}${getLocale(LocaleKey.g)}"),
      (getLocale(LocaleKey.fat), "${getLocale(LocaleKey.approx)} ${model.fat}${getLocale(LocaleKey.g)}"),
      (getLocale(LocaleKey.protein), "${getLocale(LocaleKey.approx)} ${model.protein}${getLocale(LocaleKey.g)}"),
      (getLocale(LocaleKey.fiber), "${getLocale(LocaleKey.approx)} ${model.fiber}${getLocale(LocaleKey.g)}"),
      (getLocale(LocaleKey.netCarbs), "${getLocale(LocaleKey.approx)} ${model.netCarbs}${getLocale(LocaleKey.g)}"),
      (getLocale(LocaleKey.sodium), "${getLocale(LocaleKey.approx)} ${model.sodium}${getLocale(LocaleKey.mg)}"),
      (getLocale(LocaleKey.potassium), "${getLocale(LocaleKey.approx)} ${model.potassium}${getLocale(LocaleKey.mg)}"),
      (getLocale(LocaleKey.cholesterol), "${getLocale(LocaleKey.approx)} ${model.cholesterol}${getLocale(LocaleKey.mg)}"),
    ];

    for(int i=1; i<nutritionInfo.length;i++){
      nutritionText+='${nutritionInfo[i].$1} ${nutritionInfo[i].$2}, ';
    }
  }

  ///* Today Meal
  List<TodayMealModel> todayMeals=[];
  void addTodayMeal(TodayMealModel model){
    int index=todayMeals.indexWhere((element) => element.foodItem.name==model.foodItem.name,);
    if(index<0){
      todayMeals.insert(0, model);
    }else{
      int amount=todayMeals[index].amount; // save old amount of item
      todayMeals.removeAt(index); // remove old item from list
      model.amount+=amount; // increment old amount in new
      todayMeals.insert(index, model); // replace new at old's index
    }
    update();
    Get.back();
    showSuccessSnackBar(message: "${model.amount} ${model.foodItem.name} ${getLocale(LocaleKey.addedToYourTodayMeal)}",);
  }

  void removeTodayMeal(int index){
    Get.back(); // close dialoge
    todayMeals.removeAt(index);
    update();
    if(todayMeals.isEmpty){
      Get.back(); // close food bottom sheet
    }
  }

  bool isMealExistInList(FoodItemModel model){
    int index=todayMeals.indexWhere((element) => element.foodItem.name==model.name,);
    if(index<0){
      return false;
    }
    else{
      return true;
    }
  }

  double countTotalCalories(){
    double calories=0;
    for(TodayMealModel meal in todayMeals){
      calories+=(meal.amount*meal.foodItem.calories);
    }
    return calories;
  }

  double calculateProgress(double value, double maxValue){
    double progress=0;
    progress=(value/maxValue)*100;
    return progress;
  }

  List<(Color, double,String,  String, double )> caloriesCount=[];
  void countValues(){
    caloriesCount.clear();
    double carb=0;
    double protein=0;
    double fat=0;
    double fibre=0;
    double sodium=0;
    double potassium=0;
    double netCarbs=0;
    double cholesterol=0;

    for(TodayMealModel meal in todayMeals){
      carb+=(meal.amount*meal.foodItem.carbs);
      protein+=(meal.amount*meal.foodItem.protein);
      fat+=(meal.amount*meal.foodItem.fat);
      fibre+=(meal.amount*meal.foodItem.fiber);
      sodium+=(meal.amount*meal.foodItem.sodium);
      potassium+=(meal.amount*meal.foodItem.potassium);
      netCarbs+=(meal.amount*meal.foodItem.netCarbs);
      cholesterol+=(meal.amount*meal.foodItem.cholesterol);
    }

    caloriesCount=[
      (const Color(0xff333333), calculateProgress(carb, 400),getLocale(LocaleKey.g), getLocale(LocaleKey.carbohydrates), carb,),
      (Colors.amber, calculateProgress(protein, 200),getLocale(LocaleKey.g), getLocale(LocaleKey.protein), protein,),
      ( Colors.brown, calculateProgress(fat, 100),getLocale(LocaleKey.g), getLocale(LocaleKey.fat), fat,),
      (const Color(0xffFF0000), calculateProgress(fibre, 90),getLocale(LocaleKey.g), getLocale(LocaleKey.fiber), fibre,),
      (const Color(0xffFF0000), calculateProgress(netCarbs, 70), getLocale(LocaleKey.g),getLocale(LocaleKey.netCarbs), netCarbs,),
      (const Color(0xffFF0000), calculateProgress(sodium, 1500),getLocale(LocaleKey.mg), getLocale(LocaleKey.sodium), sodium,),
      (const Color(0xffFF0000), calculateProgress(potassium, 4000),getLocale(LocaleKey.mg),getLocale(LocaleKey.potassium), potassium,),
      (const Color(0xffFF0000), calculateProgress(cholesterol, 300), getLocale(LocaleKey.mg),getLocale(LocaleKey.cholesterol), cholesterol,),
    ];
  }

  void navigateToCountCalories() {
    if (GlobalController.instance.interstitialAd == null && !isSubscribed) {
      GlobalController.instance.loadInterstitialAd(
        AdHelper.countCaloriesInterstitialAdId,
      );
      Get.dialog(const AdLoadDialoge(), barrierDismissible: false);
      Future.delayed(const Duration(seconds: 4),(){
        Get.back(); // Close Ad Load Dialoge
        if(GlobalController.instance.interstitialAd!=null && !isSubscribed){
          GlobalController.instance.interstitialAd?.show();
          Future.delayed(const Duration(seconds: 1),(){
            Get.to(() => const CaloriesCountScreen());
          });
        }else{
          Get.to(() => const CaloriesCountScreen());
        }
      });
    }else if(GlobalController.instance.interstitialAd != null && !isSubscribed){
      Get.dialog(const AdLoadDialoge(), barrierDismissible: false);
      Future.delayed(const Duration(seconds: 1),(){
        Get.back(); // Close Ad Load Dialoge
          GlobalController.instance.interstitialAd?.show();
          Future.delayed(const Duration(seconds: 1),(){
            Get.to(() => const CaloriesCountScreen());
          });
      });
    }else{
      Get.to(() => const CaloriesCountScreen());
    }
  }


  ///* Banner Ad
  BannerAd? bannerAd;

  Future<void> loadAndShowBannerAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
      Get.width.truncate(),
    );

    if (size == null) {
      debugPrint('Unable to get size of banner.');
      return;
    }
    BannerAd(
      adUnitId: AdHelper.caloriesCounterBannerAdId,
      size: size,
      request: const AdRequest(extras: {"collapsible": "bottom"}),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('Home Banner Ad Loaded');
          bannerAd = ad as BannerAd;
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint("Home Banner Ad Failed to load $error");
          ad.dispose();
          bannerAd = null;
          update();
        },
      ),
    ).load();
  }

}
