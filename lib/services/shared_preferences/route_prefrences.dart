import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/gps_tracking/model/route_model.dart';
import 'app_preferences.dart';

class RoutePreferences {
  ///
  static SharedPreferences get _instance => AppPreferences.instance;

  /// Save Route
  static const String _kRoute = "ROUTE_KEY";

  static set setRoute(RouteModel value) {
    List<String> routes = _instance.getStringList(_kRoute) ?? [];
    routes.insert(0, jsonEncode(value.toJson()));
    _instance.setStringList(_kRoute, routes);
  }

  static List<RouteModel> get getRoutes {
    List<RouteModel> routes = [];
    List<String> jsonRoute = _instance.getStringList(_kRoute) ?? [];
    for (String str in jsonRoute) {
      routes.add(RouteModel.fromJson(jsonDecode(str)));
    }
    return routes;
  }

  static set removeRoute(int value) {
    List<String> routes = _instance.getStringList(_kRoute) ?? [];
    routes.removeAt(value);
    _instance.setStringList(_kRoute, routes);
  }

  static void editRouteName(int index, String name) {
    List<String> routes = _instance.getStringList(_kRoute) ?? [];
    RouteModel model = RouteModel.fromJson(jsonDecode(routes[index]));
    model.name = name;
    routes.removeAt(index);
    routes.insert(index, jsonEncode(model.toJson()));
    _instance.setStringList(_kRoute, routes);
  }
}
