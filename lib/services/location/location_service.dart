import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';

import '../../features/workout/model/latlng_model.dart';
import '../shared_preferences/steps_preferences.dart';

Future<void> initializeLocationListener() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionStatus;

  try {
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    if (!await location.isBackgroundModeEnabled()) {
      location.enableBackgroundMode(enable: true);
    }

    permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        location.changeNotificationOptions(
          iconName: "app_icon",
          title: "Step Counter - GPS Tracking",
          description: "Update your location for gps tracking",
        );
        location.onLocationChanged.listen((LocationData currentLocation) {
          if (currentLocation.latitude != null &&
              currentLocation.longitude != null
          // && StepsPreferences.isEnableSteps
          ) {
            AppPreferences.instance.reload();
            List<LatLngModel> route = StepsPreferences.locationRoute;
            route.add(LatLngModel(
              lat: currentLocation.latitude!,
              lng: currentLocation.longitude!,
            ));
            StepsPreferences.setRouteData = route;
          }
        });
      }
    }
  } catch (e) {
    debugPrint("Background Location Exception: $e");
  }
}
