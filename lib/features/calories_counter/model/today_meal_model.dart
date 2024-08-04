import 'package:step_counter/features/calories_counter/model/food_item.dart';

class TodayMealModel {
  final FoodItemModel foodItem;
  int amount;

  TodayMealModel({required this.amount, required this.foodItem});
}
