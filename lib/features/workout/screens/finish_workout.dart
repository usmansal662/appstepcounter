import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/home/controller.dart';
import 'package:step_counter/features/home/view.dart';
import 'package:step_counter/features/workout/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';

import '../../../utils/constants.dart';

class FinishWorkOutScreen extends BaseView<WorkoutController> {
  final String time;
  final double calories;
  final int steps;
  final double distance;
  final List<LatLng> route;

  const FinishWorkOutScreen({
    super.key,
    required this.calories,
    required this.steps,
    required this.distance,
    required this.time,
    required this.route,
  });

  @override
  void initState(state) {
    super.initState(state);
    controller.isLoading = false;

    if (route.isNotEmpty) {
      controller.setProgressMarker(route.first, route.last);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.stopTimer();
    });
  }

  @override
  Color? get backgroundColor => Colors.black;

  @override
  bool get isLoading => Platform.isAndroid ? controller.isLoading : false;

  @override
  Widget? get body {
    return WillPopScope(
      onWillPop: () async {
        return Platform.isAndroid;
      },
      child: Screenshot(
        controller: controller.screenshot,
        child: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: route.isNotEmpty
                      ? LatLng(route.last.latitude, route.last.longitude)
                      : controller.latLng ?? const LatLng(0, 0),
                  zoom: 16,
                ),
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                onMapCreated: (mapController) {},
                markers: controller.progressMarker,
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('workout'),
                    color: AppColors.primaryColor,
                    points: route,
                    width: 5,
                  ),
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 260,
                width: Get.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTexts.titleText(
                      text: "$steps ${controller.getLocale(LocaleKey.steps)}",
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        activityInfo(
                            image: activityCalories,
                            text:
                                "${calories.toStringAsFixed(2)}${controller.getLocale(LocaleKey.kCal)}"),
                        activityInfo(
                            image: activityPin,
                            text:
                                "${distance.toStringAsFixed(2)}${controller.getLocale(LocaleKey.km)}"),
                        activityInfo(
                            image: activityTime,
                            text:
                                "$time${controller.getLocale(LocaleKey.min)}"),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.05),
                    !controller.isLoading
                        ? AppButton.rectangularButton(
                            text: controller.getLocale(LocaleKey.share),
                            onClick: controller.shareWorkoutProgress,
                          )
                        : const SizedBox.shrink(),
                    SizedBox(height: Get.height * 0.05),
                  ],
                ),
              ),
            ),

            /// Watermark
            Positioned(
              top: Get.height * 0.02,
              right: 20,
              child: controller.isLoading
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            appIcon,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          AppTexts.simpleText(
                            text: "Step Counter\nPedometer-GPS Map",
                            fontSize: 12,
                            color: AppColors.primaryColor.withOpacity(0.7),
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            /// Back Button
            Positioned(
              top: 10,
              left: 10,
              child: !controller.isLoading
                  ? IconButton.filled(
                      onPressed: () {
                        HomeController.instance.bannerAd?.dispose();
                        HomeController.instance.bannerAd = null;
                        Get.offAll(() => const HomeView());
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget activityInfo({required String image, required String text}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(
            AssetImage(image),
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          AppTexts.simpleText(
            text: text,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      );
}
