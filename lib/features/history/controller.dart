import 'package:get/get.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';

import 'model/history_model.dart';

class HistoryController extends BaseController {
  static final instance = Get.find<HistoryController>();

  //
  List<HistoryModel> history = [];

  //*
  String formatSeconds(int index) {
    int seconds = history[index].walkingSeconds;
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  } //*

  int calculateStepsProgress(int index) {
    int steps = history[index].steps;
    int goal = history[index].goalSteps;

    if (goal <= 0) {
      return 0;
    }

    double progressPercentage = (steps / goal) * 100;

    return progressPercentage ~/ 25;
  }
}
