import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:step_counter/services/shared_preferences/steps_preferences.dart';
import 'package:step_counter/utils/colors.dart';

import 'app_bindings.dart';
import 'core/global/global_controller.dart';
import 'features/splash/view.dart';
import 'services/google_mobile_ads/app_life_cycle_reactor.dart';
import 'services/google_mobile_ads/app_open_ad_manager.dart';

class StepCounterApp extends StatefulWidget {
  const StepCounterApp({super.key});

  @override
  State<StepCounterApp> createState() => _StepCounterAppState();
}

class _StepCounterAppState extends State<StepCounterApp>
    with WidgetsBindingObserver {
  late FirebaseAnalyticsObserver observer;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    //
    observer = FirebaseAnalyticsObserver(analytics: analytics);

    ///*
    if (Platform.isAndroid) {
      _requestConsentInfoUpdate();
    }

    //
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.hidden) {
      StepsPreferences.toggleAppState = true;
    }
    if (state == AppLifecycleState.resumed) {
      StepsPreferences.toggleAppState = false;
      bool isDialogeOpen = Get.isDialogOpen ?? false;
      if (GlobalController.instance.isInternetAvailable && isDialogeOpen) {
        Get.back();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Step Counter',
      navigatorObservers: [observer],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff312BFF)),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffoldColor,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
      ),
      debugShowCheckedModeBanner: false,
      binds: AppBinding.bindings,
      home: const SplashView(),
    );
  }

  void loadForm() {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        if (status == ConsentStatus.required) {
          consentForm.show(
            (FormError? formError) {
              // Handle dismissal by reloading form
              loadForm();
            },
          );
        }
      },
      (formError) {
        // Handle the error
      },
    );
  }

  Future<void> _requestConsentInfoUpdate() async {
    final params = ConsentRequestParameters();
    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          loadForm();
        }
      },
      (FormError? error) {
        // Handle the error
      },
    );
  }
}
