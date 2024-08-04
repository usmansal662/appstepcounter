import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/weight_and_bmi/controller.dart';
import 'package:step_counter/features/weight_and_bmi/data/bmi_index.dart';
import 'package:step_counter/features/weight_and_bmi/widgets/bmi_card.dart';
import 'package:step_counter/features/weight_and_bmi/widgets/body_zone_card.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

import '../../common_widgets/app_texts.dart';

class WeightAndBMIView extends BaseView<WeightAndBMIController> {
  const WeightAndBMIView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    if (controller.bannerAd == null && !controller.isSubscribed) {
      controller.loadAndShowBannerAd();
    }

    //*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.calculateBMI();
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
        title: controller.getLocale(LocaleKey.weightBMI),
      );

  @override
  Widget? get body => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.bodyMassIndex),
                color: Colors.black54,
              ),
              const BMICard(),

              const SizedBox(height: 10),
              //*
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.healthTip),
                color: Colors.black54,
              ),
              AppTexts.simpleText(
                text: DateFormat('MMMM dd, yyyy', AppPreferences.language)
                    .format(DateTime.now()),
                color: Colors.black38,
              ),
              const SizedBox(height: 5),
              AppTexts.simpleText(
                text: controller.getLocale(controller.bmi.healthTip),
                fontWeight: FontWeight.w700,
                fontSize: 19,
                color: controller.bmi.textColor,
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 10),

              //*
              AppTexts.titleText(
                text: controller.getLocale(LocaleKey.bodyZone),
                color: Colors.black54,
              ),
              const BodyZoneCard(),
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
}
