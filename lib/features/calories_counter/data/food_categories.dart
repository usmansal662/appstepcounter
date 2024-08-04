// import 'package:step_counter/features/calories_counter/data/breakfast.dart';
// import 'package:step_counter/features/calories_counter/data/burgers.dart';
// import 'package:step_counter/features/calories_counter/data/chicken.dart';
// import 'package:step_counter/features/calories_counter/data/desserts.dart';
// import 'package:step_counter/features/calories_counter/data/fresh_drinks.dart';
// import 'package:step_counter/features/calories_counter/data/hotdogs.dart';
// import 'package:step_counter/features/calories_counter/data/icecream_shakes.dart';
// import 'package:step_counter/features/calories_counter/data/meat.dart';
// import 'package:step_counter/features/calories_counter/data/noodles.dart';
// import 'package:step_counter/features/calories_counter/data/pastas.dart';
// import 'package:step_counter/features/calories_counter/data/pizzas.dart';
// import 'package:step_counter/features/calories_counter/data/rice.dart';
// import 'package:step_counter/features/calories_counter/data/salad.dart';
// import 'package:step_counter/features/calories_counter/data/shakes.dart';
// import 'package:step_counter/features/calories_counter/data/shawarma.dart';
// import 'package:step_counter/features/calories_counter/data/wrap.dart';
// import 'package:step_counter/features/calories_counter/model/food_cat_model.dart';
//
// import 'doner_kabab.dart';
// import 'sea_food.dart';
//
// List<FoodCategoryModel> get foodCategories => [
//       FoodCategoryModel(
//         name: "Burger",
//         image:
//             "https://static.toiimg.com/thumb/83565509.cms?width=1200&height=900",
//         items: famousBurgers,
//       ),
//       FoodCategoryModel(
//         name: "Pizza",
//         image:
//             "https://www.fourgrandmere.com/modules/psblog/uploads/1643296375.jpg",
//         items: famousPizzas,
//       ),
//       FoodCategoryModel(
//         name: "Shake",
//         image: "https://i.ytimg.com/vi/5kKvtwunjV0/maxresdefault.jpg",
//         items: famousShakes,
//       ),
//       FoodCategoryModel(
//         name: "Pasta",
//         image:
//             "https://images.aws.nestle.recipes/resized/0a0717810b73a1672a029c29788e557b_creamy_alfredo_pasta_long_left_1080_850.jpg",
//         items: pastaDishes,
//       ),
//       FoodCategoryModel(
//         name: "Breakfast",
//         image:
//             "https://thekitchencommunity.org/wp-content/uploads/2021/02/American-Breakfast-1200x675.jpg",
//         items: breakfastItems,
//       ),
//       FoodCategoryModel(
//         name: "Sea Food",
//         image:
//             "https://www.licious.in/blog/wp-content/uploads/2022/02/shutterstock_1773695441-min.jpg",
//         items: seafoodDishes,
//       ),
//       FoodCategoryModel(
//         name: "Ice Shake",
//         image:
//             "https://www.dvo.com/newsletter/weekly/2017/7-21-728/images/cooknart81.jpg",
//         items: iceCreamShakes,
//       ),
//       FoodCategoryModel(
//         name: "Noodles",
//         image:
//             "https://www.cookerru.com/wp-content/uploads/2022/09/pan-fried-noodles-main-preview-500x500.jpg",
//         items: noodleDishes,
//       ),
//       FoodCategoryModel(
//         name: "HotDogs",
//         image:
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZV0GE-3P2RPiYl6XYak-7TKOSt2SrtlQPrZ7ARWdtyQ&s",
//         items: hotdogs,
//       ),
//       FoodCategoryModel(
//         name: "Doner Kebab",
//         image:
//             "https://www.hairybikers.com/uploads/images/_recipeImage/898/kebab.jpg",
//         items: donnerKebabs,
//       ),
//       FoodCategoryModel(
//         name: "Wrap",
//         image:
//             "https://www.foodnetwork.com/content/dam/images/food/fullset/2020/10/14/0/FNK_TORTILLA_BREAKFAST_WRAP_H_f_s4x3.jpg",
//         items: wraps,
//       ),
//       FoodCategoryModel(
//         name: "Shawarma",
//         image:
//             "https://www.thedailymeal.com/img/gallery/what-a-beginner-needs-to-know-about-ordering-shawarma/l-intro-1681948540.jpg",
//         items: shawarma,
//       ),
//       FoodCategoryModel(
//         name: "Salad",
//         image:
//             "https://www.foodandwine.com/thmb/IuZPWAXBp4YaT9hn1YLHhuijT3k=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/FAW-recipes-big-italian-salad-hero-83e6ea846722478f8feb1eea33158b00.jpg",
//         items: salads,
//       ),
//       FoodCategoryModel(
//         name: "Chicken",
//         image:
//             "https://assets.epicurious.com/photos/62f16ed5fe4be95d5a460eed/1:1/w_2560%2Cc_limit/RoastChicken_RECIPE_080420_37993.jpg",
//         items: chickenItems,
//       ),
//       FoodCategoryModel(
//         name: "Meat - Beef",
//         image:
//             "https://www.safefood.net/getmedia/94101697-3c3f-4fe1-8ae8-5b595d3814ba/medium-rare-steak.jpg?w=2000&h=1333&ext=.jpg&width=1360&resizemode=force",
//         items: meatDishes,
//       ),
//       FoodCategoryModel(
//         name: "Dessert",
//         image:
//             "https://staticcookist.akamaized.net/wp-content/uploads/sites/22/2022/06/LINK-TRAFFIC-18.jpg",
//         items: desserts,
//       ),
//       FoodCategoryModel(
//         name: "Fresh Drinks",
//         image:
//             "https://ewscripps.brightspotcdn.com/dims4/default/75fa1e1/2147483647/strip/true/crop/1280x720+0+0/resize/1280x720!/quality/90/?url=https%3A%2F%2Fcdn.scrippsnews.com%2Fimages%2Fvideos%2Fx%2F1705433115_YaDsm8.jpg",
//         items: freshDrinks,
//       ),
//       FoodCategoryModel(
//         name: "Rice",
//         image:
//             "https://www.pavaniskitchen.com/wp-content/uploads/2022/05/veg-fried-rice-recipe.jpg",
//         items: riceDishes,
//       ),
//     ];
