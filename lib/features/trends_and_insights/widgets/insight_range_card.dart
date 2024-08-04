import 'package:flutter/material.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/trends_and_insights/controller.dart';

import '../../../common_widgets/app_texts.dart';
import '../../../utils/colors.dart';
import '../data/duration.dart';

class InsightRangeCard extends BaseWidget<TrendsAndInsightsController> {
  const InsightRangeCard({super.key});

  @override
  Widget get child => Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Row(
          children: List.generate(
            trendRange.length,
            (index) => Expanded(
              child: InkWell(
                onTap: () => controller.updateInsightDuration(
                  trendRange[index].insightRange,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: controller.insightDuration.name == trendRange[index]
                        ? AppColors.primaryColor
                        : Colors.white,
                  ),
                  child: AppTexts.simpleText(
                    text: controller.getLocale(trendRange[index]),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: controller.insightDuration.name == trendRange[index]
                        ? AppColors.whiteColor
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
