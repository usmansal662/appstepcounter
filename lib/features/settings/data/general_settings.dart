import 'package:get/get.dart';
import 'package:step_counter/features/settings/model/general_settings_model.dart';
import 'package:step_counter/features/settings/screens/language.dart';
import 'package:step_counter/features/settings/widgets/check_update_dialoge.dart';
import 'package:step_counter/features/settings/widgets/rate_us_bottom_sheet.dart';
import 'package:step_counter/services/share/share.dart';

import '../../../services/url_launcher/url_launch_service.dart';
import '../../../utils/app_utils.dart';

List<GeneralSettingsModel> get generalSettings => [
      GeneralSettingsModel(
        name: "Language",
        onClick: () => Get.to(() => const LanguageView()),
      ),
      GeneralSettingsModel(
        name: "Contact Us",
        onClick: UrlLaunchService.instance.launchMail,
      ),
      GeneralSettingsModel(
        name: "Rate Us",
        onClick: () => Get.bottomSheet(const RateUsBottomSheet()),
      ),
      GeneralSettingsModel(
        name: "Share App",
        onClick: ShareService.shareAppUrl,
      ),
      GeneralSettingsModel(
        name: "Privacy Policy",
        onClick: () => UrlLaunchService.instance.launchMyUrl(
          url: AppUtils.privacyPolicyUrl,
        ),
      ),
      GeneralSettingsModel(
        name: "Check for update",
        onClick: () => Get.dialog(const CheckUpdateDialoge()),
      ),
    ];
