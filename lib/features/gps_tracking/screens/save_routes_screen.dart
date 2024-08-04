import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_counter/common_widgets/app_texts.dart';
import 'package:step_counter/core/base/view/base_view.dart';
import 'package:step_counter/features/gps_tracking/controller.dart';
import 'package:step_counter/features/gps_tracking/screens/view_save_route_map.dart';
import 'package:step_counter/features/gps_tracking/widgets/save_route_dialoge.dart';
import 'package:step_counter/services/shared_preferences/route_prefrences.dart';

import '../../../common_widgets/app_bar.dart';
import '../../../localization/locale_keys.dart';

class SaveRoutesScreen extends BaseView<GPSTrackingController> {
  const SaveRoutesScreen({super.key});

  @override
  PreferredSizeWidget? get appBar => MyAppBar.regularAppBar(
        title: controller.getLocale(LocaleKey.saveRoutes),
      );

  @override
  Widget? get body => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView.separated(
          itemCount: RoutePreferences.getRoutes.length,
          itemBuilder: (_, index) {
            String name = RoutePreferences.getRoutes[index].name.isEmpty
                ? controller.getLocale(LocaleKey.unknown)
                : RoutePreferences.getRoutes[index].name;
            return Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: ListTile(
                onTap: () => Get.to(
                  () => ViewSaveRouteMapScreen(
                    name: name,
                    route: RoutePreferences.getRoutes[index].route,
                  ),
                ),
                title: AppTexts.simpleText(
                  text: name,
                  fontWeight: FontWeight.w500,
                ),
                trailing: PopupMenuButton(
                  color: Colors.white,
                  icon: const Icon(Icons.more_vert_outlined),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: AppTexts.simpleText(text: "Edit"),
                      onTap: () => Get.dialog(SaveRouteDialoge(index: index)),
                    ),
                    PopupMenuItem(
                      child: AppTexts.simpleText(
                        text: controller.getLocale(LocaleKey.delete),
                        color: Colors.red,
                      ),
                      onTap: () {
                        RoutePreferences.removeRoute = index;
                        controller.update();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(height: 5),
        ),
      );
}
