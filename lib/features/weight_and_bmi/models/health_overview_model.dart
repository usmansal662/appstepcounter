import 'package:flutter/material.dart';

class HealthOverViewModel {
  final String icon;
  final String graph;
  final String name;
  final String unit;
  final Color color;

  HealthOverViewModel({
    required this.name,
    required this.icon,
    required this.graph,
    required this.unit,
    required this.color,
  });
}
