import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/app_utils.dart';

class UrlLaunchService {
  static final instance = UrlLaunchService();

  /// launch play store
  launchPlayStore() async {
    if (await canLaunchUrlString(AppUtils.playStoreUrl)) {
      launchUrlString(AppUtils.playStoreUrl);
    } else {
      debugPrint("Google Play Store Url couldn't launch");
    }
  }

  /// launch Apple store
  launchAppleStore() async {
    if (await canLaunchUrlString(AppUtils.appleStoreUrl)) {
      launchUrlString(AppUtils.appleStoreUrl);
    } else {
      debugPrint("Google Play Store Url couldn't launch");
    }
  }

  /// launch mail
  launchMail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: AppUtils.supportMail,
      queryParameters: {
        'subject': AppUtils.appName,
      },
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      launchUrl(emailLaunchUri);
    } else {
      debugPrint("Email couldn't launch");
    }
  }

  /// launch url
  launchMyUrl({required String url}) async {
    if (await canLaunchUrlString(url)) {
      launchUrlString(url);
    } else {
      debugPrint("Url:$url couldn't launch");
    }
  }
}
