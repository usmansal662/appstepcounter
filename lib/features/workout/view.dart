import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/workout/controller.dart';
import 'package:step_counter/features/workout/widgets/finish_dialoge.dart';
import 'package:step_counter/features/workout/widgets/progress_card.dart';
import 'package:step_counter/localization/locale_keys.dart';

import '../../common_widgets/no_internet_dialoge.dart';
import '../../core/global/global_controller.dart';

class WorkoutView extends BaseView<WorkoutController> {
  final double? targetKCal;

  const WorkoutView({super.key, this.targetKCal});

  @override
  void initState(state) {
    super.initState(state);
    controller.workoutRoute.clear();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!GlobalController.instance.isInternetAvailable) {
        Get.dialog(const NoInternetDialoge(), barrierDismissible: false);
      } else {
        controller.getUserCurrentLocation();
      }
    });
  }

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(
        title: controller.getLocale(LocaleKey.startYourWorkout),
        onClick: !controller.isTimerStart
            ? null
            : () {
                controller.pauseTimer();
                Get.dialog(const FinishWorkoutDialoge());
              },
      );

  @override
  Widget? get body => WillPopScope(
        onWillPop: () async {
          return Platform.isAndroid;
        },
        child: Column(
          children: [
            ProgressCardWidget(targetKCal: targetKCal),
            const SizedBox(height: 10),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.latLng ?? const LatLng(0, 0),
                  zoom: 15,
                ),
                onMapCreated: controller.setGoogleMapController,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                polylines: controller.polylines,
                markers: controller.markers.toSet(),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );

  @override
  Widget? get bottomNavBar => controller.isTimerStart
      ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton.rectangularButton(
              text: controller.subscription!.isPaused
                  ? controller.getLocale(LocaleKey.resume)
                  : controller.getLocale(LocaleKey.pause),
              onClick: () {
                if (controller.subscription!.isPaused) {
                  controller.resumeTimer();
                } else {
                  controller.pauseTimer();
                }
              },
            ),
            const SizedBox(height: 10),
            AppButton.rectangularButton(
              text: controller.getLocale(LocaleKey.finish),
              backgroundColor: Colors.transparent,
              borderColor: Colors.black12,
              foregroundColor: Colors.black54,
              onClick: () {
                controller.pauseTimer();
                Get.dialog(const FinishWorkoutDialoge());
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        )
      : AppButton.startWorkout(
          onClick: () => controller.startTimer(targetKCal),
        );
}
