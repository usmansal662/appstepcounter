import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:step_counter/common_widgets/app_bar.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/get_started/widgets/stepper_widget.dart';
import 'package:step_counter/features/history/controller.dart';
import 'package:step_counter/features/history/widgets/grid_cards.dart';
import 'package:step_counter/features/history/widgets/target_distance.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:step_counter/utils/constants.dart';

import '../../services/shared_preferences/steps_preferences.dart';

class HistoryView extends BaseView<HistoryController> {
  const HistoryView({super.key});

  @override
  void initState(state) {
    super.initState(state);
    controller.history = StepsPreferences.history;
  }

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(
        title: controller.getLocale(LocaleKey.history),
      );

  @override
  Widget? get body => controller.history.isEmpty
      ? Center(
          child: AppTexts.titleText(
            text: controller.getLocale(LocaleKey.noHistoryExists),
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            itemCount: controller.history.length,
            itemBuilder: (_, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.titleText(
                  text: DateFormat("EEEE", AppPreferences.language)
                      .format(controller.history[index].dateTime),
                ),
                AppTexts.simpleText(
                  text:
                      "${DateFormat("dd MMM yyyy", AppPreferences.language).format(controller.history[index].dateTime)} at ${DateFormat("hh:mm a", AppPreferences.language).format(controller.history[index].dateTime)}",
                  color: Colors.black54,
                ),
                const SizedBox(height: 10),
                Card(
                  surfaceTintColor: Colors.white,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //*
                        TargetDistance(index: index),
                        const SizedBox(height: 10),

                        //*
                        GridCards(index: index),
                        const SizedBox(height: 10),

                        //*
                        ListTile(
                          leading: Image.asset(target, height: 30),
                          title: AppTexts.simpleText(
                            text: controller
                                .getLocale(LocaleKey.targetStepsAchievement),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          subtitle: AppTexts.simpleText(
                            text: controller.getLocale(
                                LocaleKey.yourAreDoingWellTowardsYourGoal),
                            fontSize: 8,
                            color: Colors.black54,
                          ),
                          trailing: AppTexts.simpleText(
                            text: "${controller.history[index].goalSteps}",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        StepperWidget(
                          currentStep:
                              controller.calculateStepsProgress(index) - 1,
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
}
