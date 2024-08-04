import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onepref/onepref.dart';
import 'package:step_counter/services/notification/push_notifications.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/step_counter.dart';

import 'core/global/global_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///* Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Push Notification Service Started
  checkForInitialMessage();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    debugPrint("Background Notification clicked open app");
  });
  registerNotification();

  /// Register Global Controller
  Bind.put(GlobalController());

  /// Initialize Shared Preferences
  await AppPreferences.init();
  AppPreferences.incrementAppCount();

  /// Initialize One Pref to identify subscription
  await OnePref.init();

  ///* Initialize Calendar Localization
  await initializeDateFormatting();

  /// Initialize Google Ad Mob
  await MobileAds.instance.initialize();

  ///* Firebase Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  //*
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );

  //*
  runApp(const StepCounterApp());
}

// insertFood() async {
//   for (FoodCategoryModel model in foodCategories) {
//     await FoodRepo.insertFoodMenuCategory(
//       FoodCategoryModel(
//         image: model.image,
//         name: model.name,
//         items: [],
//       ),
//     );
//
//     for (FoodItemModel item in model.items) {
//       await FoodRepo.insertFoodSubMenu(foodItemModel: item, menuId: model.name);
//       print(item.name);
//     }
//   }
// }
