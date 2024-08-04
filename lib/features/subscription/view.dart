import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_button.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/subscription/controller.dart';
import 'package:step_counter/features/subscription/widgets/packages.dart';
import 'package:step_counter/utils/colors.dart';

import '../../common_widgets/app_texts.dart';
import '../../common_widgets/no_internet_dialoge.dart';
import '../../core/global/global_controller.dart';
import '../../localization/locale_keys.dart';
import '../../services/url_launcher/url_launch_service.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class SubscriptionView extends BaseView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    controller.showButton=false;
    Future.delayed(const Duration(seconds: 2),(){
      controller.updateButton();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!GlobalController.instance.isInternetAvailable) {
        Get.dialog(const NoInternetDialoge(), barrierDismissible: false);
      } else if (controller.products.isEmpty) {
        controller.initStore();
      }
    });

  }

  @override
  bool get isLoading => controller.isLoading;

  @override
  Widget? get body => Stack(
        children: [
          Image.asset(
            subscription,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
              top: 30,
              bottom: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   controller.showButton? IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ):const SizedBox.shrink(),
                    Column(
                      children: [
                        AppTexts.titleText(
                          text: controller.getLocale(LocaleKey.getPremiumToday),
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        AppTexts.simpleText(
                          text:
                              controller.getLocale(LocaleKey.unlockAllFeatures),
                          color: Colors.white,
                        ),
                      ],
                    ),

                    //Transparent
                    IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: Get.height * 0.02),

                Image.asset(
                  pro,
                  height: Get.height * 0.18,
                ),

                const Packages(),

                //*

                AppTexts.titleText(
                  text: controller.getLocale(LocaleKey.whatIncluded),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    feature(title: LocaleKey.removeAds),
                    feature(title: LocaleKey.useAppSmoothly),
                  ],
                ),

                const Spacer(),

                //*
                AppButton.circularButton(
                  width: Get.width * 0.8,
                  text: controller.getLocale(LocaleKey.getPremiumNow),
                  backgroundColor: controller.products.isEmpty
                      ? AppColors.primaryColor.withOpacity(0.3)
                      : AppColors.primaryColor,
                  onClick: () {
                    if (controller.products.isNotEmpty) {
                      controller.buy();
                    }
                  },
                ),

                TextButton(
                  onPressed: controller.restore,
                  child: AppTexts.simpleText(
                    text: controller.getLocale(LocaleKey.restorePurchase),
                  ),
                ),

                //*
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text.rich(
                    textAlign: TextAlign.justify,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: controller.getLocale(LocaleKey.byPlacingOrder),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        TextSpan(
                          text: controller.getLocale(LocaleKey.termsOfService),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => UrlLaunchService.instance
                                .launchMyUrl(url: AppUtils.termsOfServiceUrl),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: controller.getLocale(LocaleKey.and),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        TextSpan(
                          text:
                              controller.getLocale(LocaleKey.subPrivacyPolicy),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => UrlLaunchService.instance
                                .launchMyUrl(url: AppUtils.privacyPolicyUrl),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: controller.getLocale(LocaleKey.subsDescription),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget feature({required String title}) => SizedBox(
        height: 30,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Checkbox(
              value: true,
              onChanged: null,
              fillColor: WidgetStatePropertyAll(
                AppColors.primaryColor,
              ),
            ),
            AppTexts.simpleText(
              text: controller.getLocale(title),
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      );
}
