import 'package:flutter/material.dart';

import '../core/global/global_controller.dart';
import '../localization/locale_keys.dart';
import 'app_texts.dart';

class AdLoadDialoge extends StatelessWidget {
  const AdLoadDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            ),
            AppTexts.simpleText(
              text: GlobalController.instance.getLocale(LocaleKey.loadingAd),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
