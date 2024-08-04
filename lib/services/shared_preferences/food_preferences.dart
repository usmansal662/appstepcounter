import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_counter/features/calories_counter/model/food_item.dart';

import 'app_preferences.dart';

class FoodPreferences {
  ///
  static SharedPreferences get _instance => AppPreferences.instance;

  /// Food Key
  static void addFood({required FoodItemModel model, required String key}) {
    List<String> encodedList = _instance.getStringList(key) ?? [];
    encodedList.add(jsonEncode(model.toJson()));
    _instance.setStringList(key, encodedList);
  }

  static void removeFood({required int index, required String key}) {
    List<String> encodedList = _instance.getStringList(key) ?? [];
    encodedList.removeAt(index);
    _instance.setStringList(key, encodedList);
  }

  static List<FoodItemModel> getUserFood(String foodCat) {
    List<FoodItemModel> list = [];
    List<String> encodedList = _instance.getStringList(foodCat) ?? [];
    for (String json in encodedList) {
      list.add(FoodItemModel.fromJson(jsonDecode(json)));
    }
    return list;
  }
}
