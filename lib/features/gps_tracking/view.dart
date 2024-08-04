import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/common_widgets/no_internet_dialoge.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/features/gps_tracking/controller.dart';
import 'package:step_counter/features/gps_tracking/screens/save_routes_screen.dart';
import 'package:step_counter/features/gps_tracking/widgets/save_route_dialoge.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/colors.dart';

class GPSTrackingView extends BaseView<GPSTrackingController> {
  const GPSTrackingView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!GlobalController.instance.isInternetAvailable) {
        Get.dialog(const NoInternetDialoge(), barrierDismissible: false);
      }
    });
  }

  @override
  bool get isLoading => controller.isLoading;

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(
        title: controller.getLocale(LocaleKey.gpsTracking),
      );

  @override
  Widget? get body => WillPopScope(
        onWillPop: () async {
          return Platform.isAndroid;
        },
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.latLng ?? const LatLng(0, 0),
                zoom: 15,
              ),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: controller.setGoogleMapController,
              markers: controller.markers,
              polylines: controller.createPolylines(controller.route),
            ),

            // saved routes
            Positioned(
              left: 20,
              top: 20,
              child: TextButton.icon(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                ),
                onPressed: () => Get.to(() => const SaveRoutesScreen()),
                label: AppTexts.simpleText(
                  text: controller.getLocale(LocaleKey.route),
                  fontWeight: FontWeight.bold,
                ),
                icon: const Icon(
                  Icons.bookmark,
                  size: 35,
                ),
              ),
            ),

            // save new route
            Positioned(
              right: 20,
              bottom: 20,
              child: IconButton.filled(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Get.dialog(const SaveRouteDialoge()),
                icon: const Icon(
                  Icons.bookmark_add_outlined,
                  size: 45,
                ),
              ),
            ),
          ],
        ),
      );
}
