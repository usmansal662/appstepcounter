import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final Color foregroundColor;
  final Widget content;
  final double aspectRatio;
  final double strokeWidth;
  final double progress;

  const CircularProgress({
    super.key,
    required this.content,
    required this.foregroundColor,
    required this.aspectRatio,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<double> notifier = ValueNotifier(0);
    return DashedCircularProgressBar.aspectRatio(
      aspectRatio: aspectRatio,
      valueNotifier: notifier,
      progress: progress,
      maxProgress: 100,
      corners: StrokeCap.butt,
      foregroundColor: foregroundColor,
      backgroundColor: const Color(0xffD9D9D9),
      foregroundStrokeWidth: strokeWidth,
      backgroundStrokeWidth: strokeWidth,
      animation: true,
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (_, double value, __) => content,
        ),
      ),
    );
  }
}
