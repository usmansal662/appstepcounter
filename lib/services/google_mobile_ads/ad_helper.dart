import 'dart:io';

class AdHelper {
  // 1
  static String get appOpenAdId {
    // Test Id Android: ca-app-pub-3940256099942544/9257395921
    // Test Id IOS: ca-app-pub-3940256099942544/5575463023

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/6738871307"
        : "ca-app-pub-9881022529615325/4863586818";
  }

  // 2
  static String get splashInterstitialAdId {
    // Test Id Android: ca-app-pub-3940256099942544/1033173712
    // Test Id IOS: ca-app-pub-3940256099942544/4411468910

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/1084834343"
        : "ca-app-pub-9881022529615325/6497314258";
  }

  // 3
  static String get homeBannerAdId {
    // Test Id Android: ca-app-pub-3940256099942544/6300978111
    // Test Id IOS: ca-app-pub-3940256099942544/2934735716

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/2589988715"
        : "ca-app-pub-9881022529615325/3474483525";
  }

  // 4
  static String get trendsAndInsightsBannerAdId {
    // Test Id Android: ca-app-pub-3940256099942544/6300978111
    // Test Id IOS: ca-app-pub-3940256099942544/2934735716

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/5024580362"
        : "ca-app-pub-9881022529615325/4727855447";
  }

  // 5
  static String get weightAndBMIBannerAdId {
    // Test Id Android: ca-app-pub-3940256099942544/6300978111
    // Test Id IOS: ca-app-pub-3940256099942544/2934735716

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/3517811591"
        : "ca-app-pub-9881022529615325/3280323669";
  }

  // 6
  static String get caloriesCounterBannerAdId {
    // Test Id Android: ca-app-pub-3940256099942544/6300978111
    // Test Id IOS: ca-app-pub-3940256099942544/2934735716

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/2669879766"
        : "ca-app-pub-9881022529615325/4514148745";
  }

  // 7
  static String get countCaloriesInterstitialAdId {
    // Test Id Android: ca-app-pub-3940256099942544/1033173712
    // Test Id IOS: ca-app-pub-3940256099942544/4411468910

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/5593310599"
        : "ca-app-pub-9881022529615325/4268690443";
  }

  // 8
  static String get saveStepGoalInterstitialAdId {
    // Test Id Android: ca-app-pub-3940256099942544/1033173712
    // Test Id IOS: ca-app-pub-3940256099942544/4411468910

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/4830893262"
        : "ca-app-pub-9881022529615325/8607390701";
  }

  // 9
  static String get finishWorkoutInterstitialAdId {
    // Test Id Android: ca-app-pub-3940256099942544/1033173712
    // Test Id IOS: ca-app-pub-3940256099942544/4411468910

    return Platform.isAndroid
        ? "ca-app-pub-9881022529615325/2398417028"
        : "ca-app-pub-9881022529615325/4577727927";
  }
}
