import 'package:flutter/material.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/settings/controller.dart';
import 'package:step_counter/features/settings/data/general_settings.dart';
import 'package:step_counter/features/settings/widgets/premium_box.dart';
import 'package:step_counter/localization/locale_keys.dart';

class SettingsView extends BaseView<SettingsController> {
  const SettingsView({super.key});

  @override
  PreferredSizeWidget? get appBar => MyAppBar.settingsAppBar(
        title: controller.getLocale(
          LocaleKey.settings,
        ),
      );

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const PremiumBox(),
            const SizedBox(height: 20),

            //*
            AppTexts.titleText(
              text: controller.getLocale(LocaleKey.generalSettings),
              color: Colors.black54,
            ),
            Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: generalSettings.length,
                  shrinkWrap: true,
                  itemBuilder: (_, index) => InkWell(
                    onTap: generalSettings[index].onClick,
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTexts.simpleText(
                            text: controller.getLocale(
                              generalSettings[index].name,
                            ),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black54,
                          )
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (_, index) => Divider(
                    thickness: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
