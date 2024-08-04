import 'package:flutter/material.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/trends_and_insights/controller.dart';
import 'package:step_counter/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/ChartData.dart';

class InsightGraph extends BaseWidget<TrendsAndInsightsController> {
  const InsightGraph({super.key});

  @override
  Widget get child => SfCartesianChart(
        enableSideBySideSeriesPlacement: true,
        enableAxisAnimation: true,
        enableMultiSelection: true,
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryYAxis: const NumericAxis(
          labelStyle: TextStyle(color: Colors.black),
        ),
        primaryXAxis: const CategoryAxis(
          labelStyle: TextStyle(color: Colors.black),
          isVisible: true,
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: <CartesianSeries<InsightsChartData, String>>[
          SplineSeries<InsightsChartData, String>(
            animationDuration: 1000,
            splineType: SplineType.cardinal,
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: AppColors.primaryColor,
              height: 10,
              width: 10,
            ),
            dataSource: controller.chartData,
            xValueMapper: (InsightsChartData data, _) => data.date,
            yValueMapper: (InsightsChartData data, _) => data.steps,
            enableTooltip: true,
            color: AppColors.primaryColor,
          )
        ],
      );

// SfCartesianChart(
//     primaryXAxis: const NumericAxis(interval: 1),
//     primaryYAxis: const NumericAxis(),
//     enableAxisAnimation: true,
//     series: <CartesianSeries>[
//       SplineAreaSeries<InsightsChartData, int>(
//         dataSource: controller.chartData,
//         xValueMapper: (InsightsChartData data, _) => data.x,
//         yValueMapper: (InsightsChartData data, _) => data.y,
//         color: AppColors.whiteColor,
//         borderColor: AppColors.primaryColor,
//         splineType: SplineType.natural,
//         dataLabelSettings: const DataLabelSettings(isVisible: true),
//         markerSettings: const MarkerSettings(
//           isVisible: true,
//           color: AppColors.primaryColor,
//           height: 10,
//           width: 10,
//         ),
//       ),
//     ]);
}
