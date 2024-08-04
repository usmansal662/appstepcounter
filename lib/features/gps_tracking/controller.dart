import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/features/workout/model/latlng_model.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/utils/constants.dart';
import 'package:step_counter/utils/snack_bar.dart';

import '../../services/shared_preferences/route_prefrences.dart';
import '../../services/shared_preferences/steps_preferences.dart';
import 'model/route_model.dart';

class GPSTrackingController extends BaseController {
  static final instance = Get.find<GPSTrackingController>();
  TextEditingController routeNameCtrl = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getUserCurrentLocation();
  }

  //
  LatLng? latLng;
  List<LatLngModel> route = StepsPreferences.locationRoute;

  Future<void> getUserCurrentLocation() async {
    PermissionStatus status = await Location().hasPermission();
    if (status == PermissionStatus.denied ||
        status == PermissionStatus.deniedForever) {
      Get.back();
      showErrorSnackBar(message: getLocale(LocaleKey.locationPermissionDenied));
      return;
    }

    if (status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited) {
      final currentLocation = await Location.instance.getLocation();
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        latLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);

        route.add(
          LatLngModel(
            lat: currentLocation.latitude!,
            lng: currentLocation.longitude!,
          ),
        );
        StepsPreferences.setRouteData = route;

        updateMarker(
          LatLng(route.first.lat, route.first.lng),
          LatLng(route.last.lat, route.last.lng),
        );
      }

      Future.delayed(Duration(seconds: Platform.isAndroid ? 5 : 30), () {
        getUserCurrentLocation();
      });
    } else {
      await Location.instance.requestPermission();
      getUserCurrentLocation();
    }
  }

  GoogleMapController? googleMapController;

  void setGoogleMapController(GoogleMapController controller) async {
    googleMapController = controller;
    if (latLng == null) {
      await getUserCurrentLocation();
    }
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng ?? const LatLng(0, 0),
          zoom: 14,
        ),
      ),
    );
  }

  Set<Polyline> createPolylines(List<LatLngModel> routeList) {
    Set<Polyline> polylines = {};

    if (routeList.isNotEmpty) {
      routeList.toSet().toList();
      List<LatLng> points = routeList
          .map((locationData) => LatLng(locationData.lat, locationData.lng))
          .toList();
      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        points: points,
        width: 5,
      ));
    }
    return polylines;
  }

  Set<Marker> markers = {};

  Future<void> updateMarker(LatLng start, LatLng end) async {
    Uint8List endIcon = await getBytesFromAssets(
      walkingPerson,
      250.toInt(),
    );
    Uint8List startIcon = await getBytesFromAssets(
      startPin,
      120.toInt(),
    );
    markers = {
      Marker(
        markerId: const MarkerId("123"),
        icon: BitmapDescriptor.fromBytes(startIcon),
        position: start,
        infoWindow: const InfoWindow(title: "Start"),
      ),
      Marker(
        markerId: const MarkerId("456"),
        icon: BitmapDescriptor.fromBytes(endIcon),
        position: end,
        infoWindow: const InfoWindow(title: "End"),
      ),
    };
    update();
  }

  //*
  GoogleMapController? mapController;
  Set<Marker> currentMarker = {};

  Future<void> setCurrentMarker() async {
    Uint8List walkIcon = await getBytesFromAssets(
      walkingPerson,
      250.toInt(),
    );

    currentMarker = {
      Marker(
        markerId: const MarkerId("person"),
        icon: BitmapDescriptor.fromBytes(walkIcon),
        position: latLng ?? const LatLng(0, 0),
      ),
    };
    update();
  }

  void saveOrEditRoute(int? index) {
    if (index == null) {
      RoutePreferences.setRoute = RouteModel(
        route: route,
        name: routeNameCtrl.text,
      );
      route.clear();
      StepsPreferences.setRouteData = [];
      showSuccessSnackBar(
        message: getLocale(LocaleKey.routeSaved),
      );
    } else {
      RoutePreferences.editRouteName(
        index,
        routeNameCtrl.text,
      );
    }
    update();
    Get.back();
    routeNameCtrl.clear();
  }
}
