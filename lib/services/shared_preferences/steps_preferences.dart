import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/features/history/model/history_model.dart';
import 'package:step_counter/features/workout/model/latlng_model.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

class StepsPreferences {
  ///
  static SharedPreferences get _instance => AppPreferences.instance;

  /// Steps Toggle
  // static const String _kStepsToggle = "TOGGLE_STEPS_KEY";
  //
  // static set toggleSteps(bool value) => _instance.setBool(_kStepsToggle, value);
  //
  // static bool get isEnableSteps => _instance.getBool(_kStepsToggle) ?? true;

  /// Foreground state
  static const String _kIOSForeground = "FOREGROUND_STATE_KEY";

  static set toggleAppState(bool value) =>
      _instance.setBool(_kIOSForeground, value);

  static bool get isForeground => _instance.getBool(_kIOSForeground) ?? false;

  /// Package Steps
  static const String _kPackageSteps = "PACKAGE_STEPS_KEY";

  static set setPackageSteps(int value) =>
      _instance.setInt(_kPackageSteps, value);

  static int get packageSteps => _instance.getInt(_kPackageSteps) ?? 0;

  /// Today Steps
  static const String _kTodaySteps = "Today_STEPS_KEY";

  static set setTodayStep(int value) => _instance.setInt(_kTodaySteps, value);

  static int get todaySteps => _instance.getInt(_kTodaySteps) ?? 0;

  /// Goal Steps
  static const String _kGoalSteps = "GOAL_STEPS_KEY";

  static set setGoalStep(int value) => _instance.setInt(_kGoalSteps, value);

  static int get goalStep => _instance.getInt(_kGoalSteps) ?? 0;

  /// Goal Steps Notification Value
  static const String _kGoalStepsNotificationValue =
      "GOAL_STEPS_NOTIFICATION_KEY";

  static set toggleNotification(bool value) =>
      _instance.setBool(_kGoalStepsNotificationValue, value);

  static bool get notificationValue =>
      _instance.getBool(_kGoalStepsNotificationValue) ?? false;

  /// Steps Route
  static const String _kStepsRoute = "STEPS_ROUTE_KEY";

  static set setRouteData(List<LatLngModel> value) {
    List<String> encodedList = [];
    for (LatLngModel model in value) {
      encodedList.add(jsonEncode(model.toJson()));
    }
    _instance.setStringList(_kStepsRoute, encodedList);
  }

  static List<LatLngModel> get locationRoute {
    List<LatLngModel> locationData = [];
    final list = _instance.getStringList(_kStepsRoute) ?? [];
    for (String str in list) {
      locationData.add(LatLngModel.fromJson(jsonDecode(str)));
    }
    return locationData;
  }

  /// Walking duration
  static const String _kStepsDuration = "STEPS_DURATION_KEY";

  static set setWalkingSecs(int value) =>
      _instance.setInt(_kStepsDuration, value);

  static int get walkingSeconds => _instance.getInt(_kStepsDuration) ?? 0;

  /// Reset Day
  static const String _kResetDay = "RESET_DAY_KEY";

  static set setDateTime(String value) =>
      _instance.setString(_kResetDay, value);

  static DateTime get currentDate {
    String dateTime = _instance.getString(_kResetDay) ?? "";

    if (dateTime.isNotEmpty) {
      return DateTime.parse(dateTime);
    } else {
      _instance.setString(_kResetDay, DateTime.now().toString());
      return DateTime.now();
    }
  }

  /// History
  static const String _kHistory = "HISTORY_KEY";

  static set setHistory(HistoryModel historyModel) {
    List<String> historyList = _instance.getStringList(_kHistory) ?? [];
    historyList.insert(0, jsonEncode(historyModel.toJson()));
    _instance.setStringList(_kHistory, historyList);
  }

  static List<HistoryModel> get history {
    List<HistoryModel> historyList = [];
    List<String> jsonList = _instance.getStringList(_kHistory) ?? [];
    for (String json in jsonList) {
      historyList.add(HistoryModel.fromJson(jsonDecode(json)));
    }
    int steps = StepsPreferences.todaySteps;
    int seconds = StepsPreferences.walkingSeconds;
    (double, double) kmAndCal =
        GlobalController.instance.calculateDistanceAndCalories(seconds, steps);
    double cal = kmAndCal.$2;
    double km = kmAndCal.$1;
    historyList.insert(
      0,
      HistoryModel(
        dateTime: DateTime.now(),
        steps: steps,
        walkingSeconds: seconds,
        distance: km,
        caloriesBurn: cal,
        goalSteps: StepsPreferences.goalStep,
      ),
    );
    return historyList;
  }
}
