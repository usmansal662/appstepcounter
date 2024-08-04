import 'package:step_counter/features/workout/model/latlng_model.dart';

class RouteModel {
  String name;
  final List<LatLngModel> route;

  RouteModel({required this.route, required this.name});

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        route: (json['route'] as List)
            .map((e) => LatLngModel.fromJson(e))
            .toList(),
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "route": route.map((e) => e.toJson()).toList(),
      };
}
