import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/trends_and_insights/controller.dart';
import 'package:step_counter/features/trends_and_insights/model/detail_info_model.dart';
import 'package:step_counter/features/trends_and_insights/widgets/insight_graph.dart';
import 'package:step_counter/features/trends_and_insights/widgets/insight_range_card.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

import 'data/duration.dart';

class TrendsAndInsightsView extends BaseView<TrendsAndInsightsController> {
  const TrendsAndInsightsView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    if (controller.bannerAd == null && !controller.isSubscribed) {
      controller.loadAndShowBannerAd();
    }

    //*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateInsights(InsightRange.day);
    });
  }

  @override
  void disposeState(state) {
    super.disposeState(state);
    controller.bannerAd?.dispose();
    controller.bannerAd = null;
  }

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(
        title: controller.getLocale(LocaleKey.trendsInsights),
      );

  @override
  Widget? get body => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InsightRangeCard(),

              const SizedBox(height: 20),
              InkWell(
                onTap: controller.rangeCalendar,
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 20),
                    AppTexts.simpleText(
                      text:
                          "${DateFormat('MMM dd, yyyy', AppPreferences.language).format(controller.startDay)} - ${DateFormat('MMM dd, yyyy', AppPreferences.language).format(controller.endDay)}",
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const InsightGraph(),

              //*
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.totalDetails),
                color: Colors.black54,
              ),
              Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      controller.totalDetails.length,
                      (index) => detailInfo(controller.totalDetails[index]),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
              //*
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.avgPerDayDetails),
                color: Colors.black54,
              ),
              Card(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      controller.avgDetails.length,
                      (index) => detailInfo(controller.avgDetails[index]),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  Widget detailInfo(DetailInfoModel info) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ImageIcon(
                    AssetImage(info.image),
                  ),
                  const SizedBox(width: 20),
                  AppTexts.simpleText(
                    text: controller.getLocale(info.title),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: AppTexts.simpleText(
                text: '....................',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Expanded(
              flex: 2,
              child: AppTexts.simpleText(
                text: info.value,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
