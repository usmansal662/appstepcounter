import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:step_counter/features/calories_counter/model/food_cat_model.dart';
import 'package:step_counter/features/calories_counter/model/food_item.dart';

class FoodRepo {
  static CollectionReference get menuCollection =>
      FirebaseFirestore.instance.collection("menu");

  static CollectionReference subMenuCollection(String menuId) =>
      FirebaseFirestore.instance
          .collection("menu")
          .doc(menuId)
          .collection("sub_menu");

  static Future<List<DocumentSnapshot>> loadFoodCategory() async {
    QuerySnapshot snapshot = await menuCollection.get();
    return snapshot.docs;
  }

  static Stream<QuerySnapshot> loadSubMenu(String menuId) {
    return subMenuCollection(menuId).snapshots();
  }

  static Future<void> insertFoodMenuCategory(
      FoodCategoryModel foodCategoryModel) async {
    await menuCollection
        .doc(foodCategoryModel.name)
        .set(foodCategoryModel.toJson());
  }

  static Future<void> insertFoodSubMenu({
    required FoodItemModel foodItemModel,
    required String menuId,
  }) async {
    await subMenuCollection(menuId)
        .doc(foodItemModel.name)
        .set(foodItemModel.toJson());
  }
}
