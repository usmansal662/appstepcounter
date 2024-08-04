import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/gps_tracking/controller.dart';
import 'package:step_counter/utils/colors.dart';

import '../../../common_widgets/app_bar.dart';
import '../../workout/model/latlng_model.dart';

class ViewSaveRouteMapScreen extends BaseView<GPSTrackingController> {
  final String name;
  final List<LatLngModel> route;

  const ViewSaveRouteMapScreen({
    super.key,
    required this.name,
    required this.route,
  });

  @override
  void initState(state) {
    super.initState(state);
    controller.setCurrentMarker();
  }

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(title: name);

  @override
  Widget? get body => WillPopScope(
        onWillPop: () async {
          return Platform.isAndroid;
        },
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(route.first.lat, route.first.lng),
            zoom: 16,
          ),
          onMapCreated: (mapController) =>
              controller.mapController = mapController,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          markers: controller.currentMarker,
          polylines: controller.createPolylines(route),
        ),
      );

  @override
  Widget? get floatingActionBtn => FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          controller.mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: controller.latLng ?? const LatLng(0, 0),
                zoom: 18,
              ),
            ),
          );
        },
        child: const Icon(Icons.gps_fixed),
      );
}
