import 'package:flutter/cupertino.dart';
import 'package:step_counter/features/calories_counter/view.dart';
import 'package:step_counter/features/trends_and_insights/view.dart';
import 'package:step_counter/features/weight_and_bmi/view.dart';
import 'package:step_counter/utils/constants.dart';

import '../model/list_tile_model.dart';

List<ListTileModel> healthTrackerData = [
  ListTileModel(
    image: trends,
    text: "Trends & Insights",
    page: const TrendsAndInsightsView(),
    subtitle: "Navigate Your Path",
  ),
  ListTileModel(
    image: bmi,
    text: "Weight & BMI",
    page: const WeightAndBMIView(),
    subtitle: "Cultivate Wellness: Track Weight, Measure Health",
  ),
  ListTileModel(
    image: gps,
    text: "GPS Tracking",
    page: Container(),
    subtitle: "Track Steps, Burn Calories, Measure Distance",
  ),
  ListTileModel(
    image: calories,
    text: "Calories Counter",
    page: const CaloriesCounterView(),
    subtitle: "Track Your Intake: Monitor Calories, Stay Balanced",
  ),
];
