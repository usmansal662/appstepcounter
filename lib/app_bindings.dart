import 'package:get/get.dart';

import 'features/calories_counter/controller.dart';
import 'features/get_started/controller.dart';
import 'features/gps_tracking/controller.dart';
import 'features/history/controller.dart';
import 'features/home/controller.dart';
import 'features/permissions/controller.dart';
import 'features/settings/controller.dart';
import 'features/splash/controller.dart';
import 'features/subscription/controller.dart';
import 'features/trends_and_insights/controller.dart';
import 'features/weight_and_bmi/controller.dart';
import 'features/workout/controller.dart';

class AppBinding extends Binding {
  @override
  List<Bind> dependencies() => bindings;
  static List<Bind> bindings = [
    Bind.put(SplashController()),
    Bind.put(GetStartedController()),
    Bind.put(PermissionController()),
    Bind.put(HomeController()),
    Bind.put(WorkoutController()),
    Bind.put(TrendsAndInsightsController()),
    Bind.put(WeightAndBMIController()),
    Bind.put(SettingsController()),
    Bind.put(SubscriptionController()),
    Bind.put(CaloriesCounterController()),
    Bind.put(HistoryController()),
    Bind.put(GPSTrackingController()),
  ];
}
