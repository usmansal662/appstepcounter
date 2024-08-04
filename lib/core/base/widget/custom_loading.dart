import 'package:flutter/material.dart';
import 'package:step_counter/utils/colors.dart';

class CustomLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomLoading({super.key, this.isLoading = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Offstage(
          offstage: !isLoading,
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
