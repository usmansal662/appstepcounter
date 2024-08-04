import 'package:flutter/material.dart';

class ListTileModel {
  final String text;
  final String image;
  final String subtitle;
  final Widget page;

  ListTileModel({
    required this.image,
    required this.text,
    required this.page,
    required this.subtitle,
  });
}
