import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItemModel {
  String name;
  int calories;
  String image;
  int carbs;
  int fat;
  int protein;
  int fiber;
  int netCarbs;
  int sodium;
  int potassium;
  int cholesterol;

  FoodItemModel({
    required this.name,
    required this.calories,
    required this.image,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.fiber,
    required this.netCarbs,
    required this.sodium,
    required this.potassium,
    required this.cholesterol,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) => FoodItemModel(
        name: json['name'],
        calories: json['calories'],
        image: json['image'],
        carbs: json['carbs'],
        fat: json['fat'],
        protein: json['protein'],
        fiber: json['fiber'],
        netCarbs: json['netCarbs'],
        sodium: json['sodium'],
        potassium: json['potassium'],
        cholesterol: json['cholesterol'],
      );

  factory FoodItemModel.fromSnapshot(DocumentSnapshot snapshot) =>
      FoodItemModel(
        name: snapshot['name'],
        calories: snapshot['calories'],
        image: snapshot['image'],
        carbs: snapshot['carbs'],
        fat: snapshot['fat'],
        protein: snapshot['protein'],
        fiber: snapshot['fiber'],
        netCarbs: snapshot['netCarbs'],
        sodium: snapshot['sodium'],
        potassium: snapshot['potassium'],
        cholesterol: snapshot['cholesterol'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        "calories": calories,
        "image": image,
        'carbs': carbs,
        'fat': fat,
        "protein": protein,
        "fiber": fiber,
        "netCarbs": netCarbs,
        "sodium": sodium,
        "potassium": potassium,
        "cholesterol": cholesterol,
      };
}
