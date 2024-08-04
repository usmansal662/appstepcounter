import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../base/controller/base_controller.dart';

class GlobalController extends BaseController {
  static final instance = Get.find<GlobalController>();

  @override
  void onInit() async {
    super.onInit();

    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.wifi)) {
      isInternetAvailable = true;
    } else if (result.contains(ConnectivityResult.mobile)) {
      isInternetAvailable = true;
    } else {
      isInternetAvailable = false;
    }

    // wait for initialize material app
    Future.delayed(const Duration(seconds: 15), () {
      /// listen internet connection
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    });
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

  ///* Internet Connection

  bool isInternetAvailable = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;


  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    bool isDialogeOpen = (Get.isDialogOpen ?? false) && Get.context != null;
    if (result.contains(ConnectivityResult.wifi)) {
      isInternetAvailable = true;

      if (isDialogeOpen) {
        Get.back();
      }
    } else if (result.contains(ConnectivityResult.mobile)) {
      isInternetAvailable = true;
      if (isDialogeOpen) {
        Get.back();
      }
    } else {
      isInternetAvailable = false;
    }
    debugPrint('Connectivity changed: $result');
  }

  InterstitialAd? interstitialAd;

  loadInterstitialAd(String adId) async {
    await InterstitialAd.load(
      adUnitId: adId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(

        ///
        onAdLoaded: (InterstitialAd ad) {
          debugPrint("Interstitial Ad Loaded");
          //*
          interstitialAd = ad;

          //*
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              interstitialAd = null;
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (err) {
          interstitialAd = null;
          debugPrint("Ad failed to load $err");
        },
      ),
    );
  }
}
