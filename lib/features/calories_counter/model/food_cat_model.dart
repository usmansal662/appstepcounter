import 'package:cloud_firestore/cloud_firestore.dart';

import 'food_item.dart';

class FoodCategoryModel {
  final String name;
  final String image;
  final List<FoodItemModel> items;

  FoodCategoryModel({
    required this.image,
    required this.name,
    required this.items,
  });

  factory FoodCategoryModel.fromSnapshot(DocumentSnapshot snapshot) =>
      FoodCategoryModel(
        image: snapshot['image'],
        name: snapshot['name'],
        items: [],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        "name": name,
        "items": items.map((e) => e.toJson()).toList(),
      };
}
