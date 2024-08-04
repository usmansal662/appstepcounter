import 'package:flutter/material.dart';

/*
    UNDERWEIGHT: BMI less than 18.5
    NORMAL: BMI 18.5 to 24.9
    OVERWEIGHT: BMI 25 to 29.9
    OBESE: BMI 30 to 34.9
    EXTREMELY OBESE: BMI 35 and above
    * */

List<double> bmiIndex = [15, 18.5, 25, 30, 40];

extension Status on double {
  String get healthStatus {
    switch (this) {
      case <= 18.5:
        return "Improve your health";
      case > 18.5 && <= 24.9:
        return "You're healthy";
      case > 24.9 && <= 29.9:
        return "Lose your weight";
      case > 29.9 && <= 34.9:
        return "You're at risk";
      case > 34.9:
        return "You're at serious risk";
      default:
        return '';
    }
  }
}

extension HealthTip on double {
  String get healthTip {
    switch (this) {
      case <= 18.5:
        return 'Focus on nutrient-rich foods for healthy weight gain. Consult with a dietitian for personalized guidance';
      case > 18.5 && <= 24.9:
        return "Maintain balanced habits with nutritious eating, exercise, and stress management for overall well-being.";
      case > 24.9 && <= 29.9:
        return "Prioritize weight loss through healthy eating and regular exercise. Seek professional guidance for sustainable changes.";
      case > 29.9 && <= 34.9:
        return "Reduce health risks by focusing on balanced diet, exercise, and medical support for weight management.";
      case > 34.9 && <= 39.9:
        return "Address severe health risks through comprehensive lifestyle changes and medical intervention as needed.";
      case > 39.9:
        return "Urgently seek medical attention and support to manage weight and improve overall health.";
      default:
        return '';
    }
  }
}

extension HealthColor on double {
  Color get textColor {
    switch (this) {
      case <= 18.5:
        return const Color(0xff43A5FF);
      case > 18.5 && <= 24.9:
        return const Color(0xff3BC444);
      case > 24.9 && <= 29.9:
        return const Color(0xfff2cb07);
      case > 29.9 && <= 34.9:
        return const Color(0xfff26500);
      case > 34.9:
        return const Color(0xfff21124);
      default:
        return Colors.white;
    }
  }
}

extension HealthColor2 on double {
  Color get cardColor {
    switch (this) {
      case <= 18.5:
        return const Color(0xffcde3f7);
      case > 18.5 && <= 24.9:
        return const Color(0xffD5FFD8);
      case > 24.9 && <= 29.9:
        return const Color(0xffe0d392);
      case > 29.9 && <= 34.9:
        return const Color(0xfff2d2bb);
      case > 34.9:
        return const Color(0xfff2bbbb);
      default:
        return Colors.white70;
    }
  }
}
