import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pedometer/pedometer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:step_counter/common_widgets/ad_load_dialoge.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/core/global/global_controller.dart';
import 'package:step_counter/features/calories_counter/controller.dart';
import 'package:step_counter/services/google_mobile_ads/ad_helper.dart';
import 'package:step_counter/utils/snack_bar.dart';

import '../../services/notification/local_notification.dart';
import '../../services/share/share.dart';
import '../../utils/constants.dart';
import 'screens/finish_workout.dart';

class WorkoutController extends BaseController {
  static final instance = Get.find<WorkoutController>();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    getUserCurrentLocation();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  ///* Timer
  StreamSubscription? subscription;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool isTimerStart = false;
  double cal = 0;
  double km = 0;
  int steps = 0;
  int packageStep = 0;

  void startTimer(double? targetKCal) {
    if (GlobalController.instance.interstitialAd == null && !isSubscribed) {
      GlobalController.instance.loadInterstitialAd(
        AdHelper.finishWorkoutInterstitialAdId,
      );
    }
    isTimerStart = true;

    update();
    subscription = null;
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng ?? const LatLng(0, 0),
          zoom: 18,
        ),
      ),
    );
    getUserCurrentLocation();
    countSteps(targetKCal);
    subscription = Stream.periodic(const Duration(seconds: 1)).listen((event) {
      if (sec == 60) {
        min++;
        sec = 0;
      }
      if (min == 60) {
        hour++;
        min = 0;
      }
      sec++;

      if (Platform.isIOS && isWalking && isTimerStart) {
        walkingSec++;
        steps = (walkingSec * 1.4).round(); // average step per second = 1.4
        (double, double) kmAndCal =
            calculateDistanceAndCalories(walkingSec, steps);
        cal = kmAndCal.$2;
        km = kmAndCal.$1;
        update();
        if (targetKCal != null && targetKCal.round() == cal.round()) {
          showNotification(
            title: "Hurrah! 🎊🎉",
            body: "You've Hit Your Calorie Burn Goal!",
          );
        }
      }
      update();
    });
  }

  void pauseTimer() {
    subscription?.pause();
    update();
  }

  void resumeTimer() {
    subscription?.resume();
    update();
  }

  void stopTimer() {
    subscription?.cancel();
    isTimerStart = false;
    sec = 0;
    steps = 0;
    min = 0;
    hour = 0;
    cal = 0;
    km = 0;
    walkingSec = 0;
    workoutRoute.clear();
    polylines.clear();
    markers.clear();
    update();
    CaloriesCounterController.instance.todayMeals.clear();
    CaloriesCounterController.instance.update();
    if (latLng != null) {
      updateMarker(latLng!, latLng!);
    }
  }

  int walkingSec = 0;

  bool isWalking = false;

  countSteps(double? targetCal) {
    if (Platform.isAndroid) {
      Pedometer.stepCountStream.listen((event) {
        if (event.steps > packageStep) {
          if (packageStep != 0) {
            if (isTimerStart &&
                subscription != null &&
                !subscription!.isPaused) {
              steps += event.steps - packageStep;
              walkingSec++;
              (double, double) kmAndCal =
                  calculateDistanceAndCalories(walkingSec, steps);
              cal = kmAndCal.$2;
              km = kmAndCal.$1;
              update();
              if (targetCal != null && targetCal.round() == cal.round()) {
                showNotification(
                  title: "Hurrah! 🎊🎉",
                  body: "You've Hit Your Calorie Burn Goal!",
                );
              }
            }
          }
          packageStep = event.steps;
        }
      });
    }
    if (Platform.isIOS) {
      Pedometer.pedestrianStatusStream.listen((event) {
        debugPrint("Walking Status: ${event.status}");
        if (event.status.toLowerCase() == 'walking') {
          isWalking = true;
        } else {
          isWalking = false;
        }
      }).onError((error) {});
    }
  }

  void finishWorkout() {
    Get.back(); // close finish workout dialoge
    if (GlobalController.instance.interstitialAd != null && !isSubscribed) {
      Get.dialog(const AdLoadDialoge(), barrierDismissible: false);
      Future.delayed(const Duration(seconds: 1), () {
        Get.back(); // close Ad Load dialoge
        GlobalController.instance.interstitialAd?.show();
        Future.delayed(const Duration(seconds: 1), () {
          Get.to(() => FinishWorkOutScreen(
                calories: cal,
                steps: steps,
                distance: km,
                time: (hour * 60 + min).toString(),
                route: List.from(workoutRoute),
              ))?.then((val) {
            polylines = {};
            workoutRoute.clear();
            update();
          });
        });
      });
    } else {
      Get.to(() => FinishWorkOutScreen(
            calories: cal,
            steps: steps,
            distance: km,
            time: (hour * 60 + min).toString(),
            route: List.from(workoutRoute),
          ))?.then((val) {
        polylines = {};
        workoutRoute.clear();
        update();
      });
    }
  }

  ///* Share Workout Progress
  ScreenshotController screenshot = ScreenshotController();
  GlobalKey screen = GlobalKey();

  Future<void> shareWorkoutProgress() async {
    isLoading = true;
    update();

    //*
    final directory = await getApplicationDocumentsDirectory();

    String? path;
    if (Platform.isAndroid) {
      path = await screenshot.captureAndSave(directory.path);
    } else {
      await Future.delayed(const Duration(milliseconds: 500), () async {
        path = await NativeScreenshot.takeScreenshot();
      });
    }

    if (path != null) {
      ShareService.shareImageWithUrl([XFile(path!)]);
    } else {
      showErrorSnackBar(message: "Try Again! Error in capturing progress..");
    }

    isLoading = false;
    update();
  }

  ///*
  LatLng? latLng;
  List<LatLng> workoutRoute = [];

  getUserCurrentLocation() async {
    PermissionStatus status = await Location().hasPermission();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.grantedLimited) {
      final currentLocation = await Location.instance.getLocation();
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        latLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);

        workoutRoute.add(latLng!);
        createPolylines(workoutRoute);
        if (workoutRoute.length == 1) {
          await updatePosition();
        }
        updateMarker(workoutRoute.first, workoutRoute.last);
      }

      Future.delayed(const Duration(seconds: 5), () {
        if (isTimerStart && subscription != null && !subscription!.isPaused) {
          getUserCurrentLocation();
        }
      });
    } else {
      await Location.instance.requestPermission();
      getUserCurrentLocation();
    }
  }

  ///*

  GoogleMapController? googleMapController;

  void setGoogleMapController(GoogleMapController controller) {
    googleMapController = controller;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng ?? const LatLng(0, 0),
          zoom: 14,
        ),
      ),
    );
    update();
  }

  Future<void> updatePosition() async {
    await googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng ?? const LatLng(0, 0),
          zoom: isTimerStart ? 18 : 14,
        ),
      ),
    );
  }

  Set<Polyline> polylines = {};

  void createPolylines(List<LatLng> route) {
    polylines = {
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.blue,
        points: route,
        width: 5,
      ),
    };
    update();
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
  Set<Marker> progressMarker = {};

  Future<void> setProgressMarker(LatLng start, LatLng end) async {
    Uint8List walkIcon = await getBytesFromAssets(
      startPin,
      120.toInt(),
    );

    progressMarker = {
      Marker(
        markerId: const MarkerId("start"),
        icon: BitmapDescriptor.fromBytes(walkIcon),
        position: start,
      ),
      Marker(
        markerId: const MarkerId("end"),
        icon: BitmapDescriptor.fromBytes(walkIcon),
        position: end,
      ),
    };
    update();
  }
}
