import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/features/history/model/history_model.dart';
import 'package:step_counter/features/trends_and_insights/model/ChartData.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../services/google_mobile_ads/ad_helper.dart';
import '../../services/shared_preferences/steps_preferences.dart';
import '../../utils/constants.dart';
import 'data/duration.dart';
import 'model/detail_info_model.dart';

class TrendsAndInsightsController extends BaseController {
  static final instance = Get.find<TrendsAndInsightsController>();

  @override
  void onInit() {
    super.onInit();
    updateInsights(InsightRange.day);
  }

  ///* Duration
  InsightRange insightDuration = InsightRange.day;

  void updateInsightDuration(InsightRange value) {
    insightDuration = value;
    updateInsights(value);
  }

  //*
  DateTime startDay = DateTime.now();
  DateTime endDay = DateTime.now();

  void rangeCalendar() async {
    List<DateTime?>? results = await showCalendarDatePicker2Dialog(
      context: Get.context!,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        cancelButton: AppTexts.simpleText(
          text: getLocale(LocaleKey.cancel),
        ),
        okButton: AppTexts.simpleText(
          text: getLocale(LocaleKey.ok),
        ),
      ),
      dialogSize: const Size(325, 400),
      value: [
        DateTime.now(),
      ],
      borderRadius: BorderRadius.circular(15),
    );
    if (results != null && results.isNotEmpty) {
      if (results[0] != null) {
        startDay = results[0]!;
      }
      if (results[results.length - 1] != null) {
        endDay = results[results.length - 1]!;
      }
    }
    updateInsights(insightDuration);
  }

  List<InsightsChartData> chartData = [];
  late int totalSteps;
  late int avgSteps;
  late double totalKm;
  late double avgKm;
  late double totalCal;
  late double avgCal;
  List<DetailInfoModel> totalDetails = [];
  List<DetailInfoModel> avgDetails = [];

  void updateInsights(InsightRange range) {
    totalSteps = 0;
    avgSteps = 0;
    totalKm = 0;
    avgKm = 0;
    totalCal = 0;
    avgCal = 0;
    chartData.clear();
    List<HistoryModel> list = [];
    List<HistoryModel> history = StepsPreferences.history;

    //* Filter list in range
    for (HistoryModel model in history) {
      bool isInRange =
          model.dateTime.isAfter(startDay) && model.dateTime.isBefore(endDay);
      bool isSameStartDay = model.dateTime.day == startDay.day &&
          model.dateTime.month == startDay.month &&
          model.dateTime.year == startDay.year;
      bool isSameEndDay = model.dateTime.day == endDay.day &&
          model.dateTime.month == endDay.month &&
          model.dateTime.year == endDay.year;

      if (isInRange || isSameStartDay || isSameEndDay) {
        list.add(model);
      }
    }

    ///* Differentiate by daily, weekly, monthly, yearly
    //* Daily
    if (range == InsightRange.day) {
      for (HistoryModel model in list) {
        chartData.add(
          InsightsChartData(
            DateFormat("dd/MM").format(model.dateTime),
            model.steps,
          ),
        );
        totalSteps += model.steps;
        totalKm += model.distance;
        totalCal += model.caloriesBurn;
      }
    }

    //* Weekly
    if (range == InsightRange.week) {
      DateTime weekStartDate = startDay;
      int weekCount = 1;
      int steps = 0;

      for (HistoryModel model in list) {
        DateTime currentDate = model.dateTime;
        // Calculate the difference in days between the current date and the week start date
        int dayDifference = currentDate.difference(weekStartDate).inDays;

        if (dayDifference >= 7) {
          // If the current date is in a new week, add the accumulated steps to chartData
          chartData.add(InsightsChartData("Week$weekCount", steps));
          weekCount++;
          steps = 0;
          // Update the week start date to the start of the current week
          weekStartDate =
              weekStartDate.add(Duration(days: (dayDifference ~/ 7) * 7));
        }

        steps += model.steps;
        totalSteps += model.steps;
        totalKm += model.distance;
        totalCal += model.caloriesBurn;
      }

      // Add the remaining steps for the last week
      if (steps != 0) {
        chartData.add(InsightsChartData("Week$weekCount", steps));
      }
    }

    //* Monthly
    if (range == InsightRange.month) {
      int steps = 0;
      String month = DateFormat("MM/yy").format(startDay);

      for (HistoryModel model in list) {
        if (month != DateFormat("MM/yy").format(model.dateTime)) {
          chartData.add(
            InsightsChartData(
              month,
              steps,
            ),
          );
          steps = 0;
          month = DateFormat("MM/yy").format(model.dateTime);
        }
        steps += model.steps;
        totalSteps += model.steps;
        totalKm += model.distance;
        totalCal += model.caloriesBurn;
      }
      if (chartData.isEmpty || chartData.last.date != month) {
        chartData.add(InsightsChartData(month, steps));
      }
    }

    //* Yearly
    if (range == InsightRange.year) {
      int steps = 0;
      int yearNum = startDay.year;

      for (HistoryModel model in list) {
        steps += model.steps;
        totalSteps += model.steps;
        totalKm += model.distance;
        totalCal += model.caloriesBurn;
        if (yearNum != model.dateTime.year) {
          chartData.add(InsightsChartData(yearNum.toString(), steps));
          steps = 0;
          yearNum = model.dateTime.year;
        }
      }
      if (chartData.isEmpty || chartData.last.date != yearNum.toString()) {
        chartData.add(
          InsightsChartData(yearNum.toString(), steps),
        );
      }
    }

    if (chartData.isNotEmpty) {
      avgSteps = totalSteps ~/ chartData.length;
      avgCal = totalCal / chartData.length;
      avgKm = totalKm / chartData.length;
    }

    debugPrint("Total Steps: $totalSteps");
    debugPrint("Total Calories: $totalCal");
    debugPrint("Total Km: $totalKm");

    debugPrint("Avg. Total Steps: $avgSteps");
    debugPrint("Avg. Total Calories: $avgCal");
    debugPrint("Avg. Total Km: $avgKm");

    totalDetails = [
      DetailInfoModel(
        title: "Step",
        image: stepWalk,
        value: totalSteps.toString(),
      ),
      DetailInfoModel(
        title: "Distance",
        image: activityPin,
        value: '${totalKm.toStringAsFixed(2)}${getLocale(LocaleKey.km)}',
      ),
      DetailInfoModel(
        title: "Burned",
        image: activityCalories,
        value: "${totalCal.toStringAsFixed(1)}${getLocale(LocaleKey.kCal)}",
      ),
    ];
    avgDetails = [
      DetailInfoModel(
        title: "Step",
        image: stepWalk,
        value: avgSteps.toString(),
      ),
      DetailInfoModel(
        title: "Distance",
        image: activityPin,
        value: '${avgKm.toStringAsFixed(2)}${getLocale(LocaleKey.km)}',
      ),
      DetailInfoModel(
        title: "Burned",
        image: activityCalories,
        value: "${avgCal.toStringAsFixed(1)}${getLocale(LocaleKey.kCal)}",
      ),
    ];
    update();
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
      adUnitId: AdHelper.trendsAndInsightsBannerAdId,
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
