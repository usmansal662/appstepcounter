import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/common_widgets/app_text_field.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/gps_tracking/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/route_prefrences.dart';
import 'package:step_counter/utils/colors.dart';

class SaveRouteDialoge extends BaseWidget<GPSTrackingController> {
  final int? index;

  const SaveRouteDialoge({super.key, this.index});

  @override
  Widget get child => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppTexts.titleText(
          text: controller.getLocale(LocaleKey.saveYourRoute),
        ),
        content: AppTextField.borderTextField(
          controller: controller.routeNameCtrl,
          hintText: index == null
              ? controller.getLocale(LocaleKey.routeName)
              : RoutePreferences.getRoutes[index!].name,
        ),
        actions: [
          AppButton.circularButton(
            width: 100,
            height: 40,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            borderColor: AppColors.blackColor,
            text: controller.getLocale(LocaleKey.cancel),
            onClick: () {
              controller.routeNameCtrl.clear();
              Get.back();
            },
          ),
          AppButton.circularButton(
            width: 100,
            height: 40,
            text: controller.getLocale(LocaleKey.save),
            onClick: () => controller.saveOrEditRoute(index),
          ),
        ],
      );
}
