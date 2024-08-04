import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class StepperWidget extends StatelessWidget {
  final int currentStep;

  const StepperWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          height: 8,
          width: 60,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color:
                index <= currentStep ? AppColors.primaryColor : Colors.black12,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
