import 'package:flutter/material.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/settings/controller.dart';
import 'package:step_counter/features/settings/data/languages.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/utils/colors.dart';

class LanguageView extends BaseView<SettingsController> {
  const LanguageView({super.key});

  @override
  PreferredSizeWidget? get appBar => MyAppBar.settingsAppBar(title: "Language");

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: languages.length,
          itemBuilder: (_, index) => ListTile(
            onTap: () => controller.setLocal(languages[index].code),
            title: AppTexts.simpleText(
              text: languages[index].name,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            trailing: Icon(
              Icons.brightness_1,
              color: AppPreferences.language == languages[index].code
                  ? AppColors.primaryColor
                  : const Color(0xffC2CDDC),
            ),
          ),
          separatorBuilder: (_, index) => Divider(
            thickness: 0.5,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      );
}
