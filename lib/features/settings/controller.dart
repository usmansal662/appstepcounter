import 'dart:io';

import 'package:get/get.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';

import '../../services/url_launcher/url_launch_service.dart';

class SettingsController extends BaseController {
  static final instance = Get.find<SettingsController>();

//
  int rating = 0;

  void updateRate(int value) {
    rating = value;
    update();
  }

  void submitRating() {
    //
    if (Platform.isAndroid) {
      //*
      if (rating <= 3) {
        UrlLaunchService.instance.launchMail();
      } else {
        UrlLaunchService.instance.launchPlayStore();
      }
    }

    //
    if (Platform.isIOS) {
      UrlLaunchService.instance.launchAppleStore();
    }
  }
}
