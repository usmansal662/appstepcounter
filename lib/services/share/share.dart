import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/app_utils.dart';
import '../../utils/snack_bar.dart';

class ShareService {
  static String text =
      'Google Play Store: ${AppUtils.playStoreUrl}\nApple Store: ${AppUtils.appleStoreUrl}';

  /// Share Image
  static Future<void> shareImage(List<XFile> files) async {
    try {
      await Share.shareXFiles(files);
    } catch (e) {
      debugPrint("Share File Exception: $e");
    }
  }

  /// Share Image With Url
  static Future<void> shareImageWithUrl(List<XFile> files) async {
    try {
      await Share.shareXFiles(
        files,
        text: 'Share via *${AppUtils.appName.toUpperCase()}*\n$text',
      );
    } catch (e) {
      debugPrint("Share File Exception: $e");
    }
  }

  /// share app
  static Future<void> shareAppUrl() async {
    final result = await Share.share(text);
    if (result.status == ShareResultStatus.success) {
      showSuccessSnackBar(message: "Thank you for sharing our app");
    }
  }
}
