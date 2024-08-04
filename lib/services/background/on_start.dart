import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pedometer/pedometer.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/services/shared_preferences/steps_preferences.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import '../../features/get_started/data/gender_enum.dart';
import '../../features/history/model/history_model.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestSoundPermission: false,
          defaultPresentAlert: false,
          defaultPresentBanner: false,
          defaultPresentSound: false,
        ),
        android: AndroidInitializationSettings('app_icon'),
      ),
    );
  }

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      // if you don't using custom notification, uncomment this
      service.setForegroundNotificationInfo(
        title: "Step Counter - GPS Map",
        content: "Background service is running",
      );
    }
  }

  await AppPreferences.init();
  bool isWalking = false;

  /// calculate Distance And Calories
  double getWeightInKg(String weightStr) {
    double weight;
    if (weightStr.endsWith('Kg')) {
      final split = weightStr.split(' ');
      weight = double.parse(split.first);
    } else {
      final split = weightStr.split(' ');
      weight = double.parse(split.first) * 0.45359237;
    }
    return weight;
  }

  double getHeightInMeters(String heightStr) {
    double height;
    if (heightStr.endsWith('Cm')) {
      final split = heightStr.split(' ');
      height = double.parse(split.first) / 100;
    } else {
      final split = heightStr.split(' ');
      height = double.parse(split.first) * 0.3048;
    }
    return height;
  }

  (double, double) calculateDistanceAndCalories(int seconds, int steps) {
    double weight = getWeightInKg(AppPreferences.weight);
    double height = getHeightInMeters(AppPreferences.height) * 100;
    double age = double.parse(AppPreferences.age);

    double metWalking = 3.5;

    double distanceMeters = steps * 0.75; // Average step length in meters=0.75
    double distanceKm = distanceMeters / 1000;

    // BMR (Basal Metabolic Rate) in kcal/day using Mifflin St Jeor equation
    double bmr = 0;
    if (AppPreferences.gender.gender == Gender.male) {
      // For Men:
      // BMR = 10 * weight (in kg) + 6.25 * height (in cm) - 5 * age (in years) + 5

      bmr = 10 * weight + 6.25 * height * 100 - 5 * age + 5;
    }
    if (AppPreferences.gender.gender == Gender.female) {
      // For Women:
      // BMR = 10 * weight (in kg) + 6.25 * height (in cm) - 5 * age (in years) - 161
      bmr = 10 * weight + 6.25 * height * 100 - 5 * age - 161;
    }

    // Calories burned in kcal
    double caloriesBurned = bmr * metWalking * distanceKm / weight;
    double kCal = caloriesBurned / 1000;

    return (distanceKm, kCal);
  }

  /// Goal Notification
  void showNotification({required String title, required String body}) {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'notification',
      'Channel for notification',
      icon: '@mipmap/ic_launcher_rounded',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      playSound: true,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  /// Day Reset
  DateTime currentDate = StepsPreferences.currentDate;
  int todaySteps = StepsPreferences.todaySteps;
  int walkingSeconds = StepsPreferences.walkingSeconds;
  int goalStep = StepsPreferences.goalStep;
  bool isSendNotification = StepsPreferences.notificationValue;

  Stream.periodic(const Duration(seconds: 1)).listen((event) async {
    if (currentDate.day != DateTime.now().day) {
      (double, double) distanceAndCalories =
          calculateDistanceAndCalories(walkingSeconds, todaySteps);
      double caloriesBurn = distanceAndCalories.$2;
      double distance = distanceAndCalories.$1;

      //*
      StepsPreferences.setHistory = HistoryModel(
        dateTime: currentDate,
        steps: todaySteps,
        walkingSeconds: walkingSeconds,
        distance: distance,
        caloriesBurn: caloriesBurn,
        goalSteps: goalStep,
      );

      //*
      currentDate = DateTime.now();
      todaySteps = 0;
      walkingSeconds = 0;
      isSendNotification = false;
      StepsPreferences.setDateTime = currentDate.toString();
      StepsPreferences.setTodayStep = todaySteps;
      StepsPreferences.setWalkingSecs = walkingSeconds;
      StepsPreferences.setRouteData = [];
      StepsPreferences.toggleNotification = isSendNotification;
    }

    /// Notification
    AppPreferences.instance.reload();
    currentDate = StepsPreferences.currentDate;
    todaySteps = StepsPreferences.todaySteps;
    walkingSeconds = StepsPreferences.walkingSeconds;
    goalStep = StepsPreferences.goalStep;
    isSendNotification = StepsPreferences.notificationValue;
    if (Platform.isIOS && !StepsPreferences.isForeground) {
      //*
      (double, double) kmAndCal = calculateDistanceAndCalories(
        walkingSeconds,
        todaySteps,
      );
      flutterLocalNotificationsPlugin.show(
        888,
        "",
        "👟$todaySteps Steps 📍${kmAndCal.$1.toStringAsFixed(2)}Km 🔥${kmAndCal.$2.toStringAsFixed(2)}kCal ${isWalking ? '🚶' : ''}",
        NotificationDetails(
          android: AndroidNotificationDetails(
            'my_foreground',
            'MY FOREGROUND SERVICE',
            subText: "🎯Goal $goalStep Steps",
            priority: Priority.high,
            importance: Importance.high,
            autoCancel: true,
            showProgress: true,
            icon: "@mipmap/ic_launcher_rounded",
            maxProgress: goalStep,
            progress: todaySteps,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: false,
            presentSound: false,
            presentBanner: false,
            presentBadge: false,
          ),
        ),
      );
    }
  });

  if (Platform.isAndroid || Platform.isIOS) {
    /// Steps Listener
    Pedometer.stepCountStream.listen((event) {
      if (event.steps > StepsPreferences.packageSteps) {
        if (StepsPreferences.packageSteps != 0) {
          // if (StepsPreferences.isEnableSteps && isWalking) {
          todaySteps += event.steps - StepsPreferences.packageSteps;
          StepsPreferences.setTodayStep = todaySteps;
          // }
        }
        if (todaySteps >= goalStep && goalStep != 0 && !isSendNotification) {
          showNotification(
            title: "Hurrah! 🎊🎉",
            body: "You have completed your steps goal today.",
          );
          StepsPreferences.toggleNotification = true;
        }
      }
      StepsPreferences.setPackageSteps = event.steps;

      /// Progress Notification
      if (Platform.isAndroid) {
        //*
        (double, double) kmAndCal = calculateDistanceAndCalories(
          walkingSeconds,
          todaySteps,
        );
        flutterLocalNotificationsPlugin.show(
          888,
          "",
          "👟$todaySteps Steps 📍${kmAndCal.$1.toStringAsFixed(2)}Km 🔥${kmAndCal.$2.toStringAsFixed(2)}kCal ${isWalking ? '🚶' : ''}",
          NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              subText: "🎯Goal $goalStep Steps",
              priority: Priority.high,
              importance: Importance.high,
              autoCancel: true,
              showProgress: true,
              icon: "@mipmap/ic_launcher_rounded",
              maxProgress: goalStep,
              progress: todaySteps,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: false,
              presentSound: false,
              presentBanner: false,
              presentBadge: false,
            ),
          ),
        );
      }
    });

    /// Walking Seconds
    StreamSubscription? subscription;
    Pedometer.pedestrianStatusStream.listen((event) {
      debugPrint("Walking Status: ${event.status}");
      if (event.status.toLowerCase() == 'walking') {
        isWalking = true;
        if (subscription == null) {
          subscription =
              Stream.periodic(const Duration(seconds: 1)).listen((event) {
            // if (StepsPreferences.isEnableSteps) {
            walkingSeconds++;
            StepsPreferences.setWalkingSecs = walkingSeconds;
            // }
          });
        } else {
          subscription?.resume();
        }
      } else {
        isWalking = false;
        subscription?.pause();
      }
    }).onError((error) {});
  }
}
