import 'package:flutter/material.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/home/controller.dart';

class HealthTrackerCard extends BaseWidget<HomeController> {
  final String image;
  final String title;
  final String subtitle;

  const HealthTrackerCard({
    super.key,
    required this.subtitle,
    required this.title,
    required this.image,
  });

  @override
  Widget get child => Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: ListTile(
          leading: Image.asset(
            image,
            height: 30,
            width: 30,
          ),
          title: AppTexts.titleText(
            text: controller.getLocale(title),
            fontSize: 14,
          ),
          subtitle: AppTexts.simpleText(
            text: controller.getLocale(subtitle),
            fontSize: 8,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      );
}
