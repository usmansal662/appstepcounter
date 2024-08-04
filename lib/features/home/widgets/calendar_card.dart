import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_counter/core/base/widget/base_widget.dart';
import 'package:step_counter/features/home/controller.dart';
import 'package:step_counter/localization/locale_keys.dart';
import 'package:step_counter/services/shared_preferences/app_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/font_family.dart';

class CalendarCard extends BaseWidget<HomeController> {
  const CalendarCard({super.key});

  @override
  Widget get child => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${controller.getLocale(LocaleKey.today)} ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: 22,
                        fontFamily: FontFamily.poppin,
                      ),
                    ),
                    TextSpan(
                      text: DateFormat('(dd MMMM)', AppPreferences.language)
                          .format(DateTime.now()),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: FontFamily.poppin,
                      ),
                    ),
                  ],
                ),
              ),
              // TextButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(
              //     CupertinoIcons.repeat,
              //     color: Colors.black,
              //   ),
              //   label: AppTexts.simpleText(text: "Reset"),
              // )
            ],
          ),
          Divider(
            color: Colors.black12,
            indent: Get.width * 0.05,
            endIndent: Get.width * 0.05,
          ),
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2050, 1, 1),
            focusedDay: controller.focusDay,
            onPageChanged: controller.updateFocusDay,
            calendarFormat: CalendarFormat.week,
            headerVisible: true,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            locale: AppPreferences.language,
            daysOfWeekHeight: 22,
          ),
        ],
      );
}
