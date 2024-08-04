// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:step_counter/common_widgets/app_texts.dart';
// import 'package:step_counter/core/base/view/base_view.dart';
// import 'package:step_counter/features/calories_counter/controller.dart';
// import 'package:step_counter/features/calories_counter/screens/food_detail.dart';
//
// import '../../../common_widgets/app_button.dart';
// import '../../../utils/constants.dart';
//
// class SubMenuScreen extends BaseView<CaloriesCounterController> {
//   const SubMenuScreen({super.key});
//
//   @override
//   Widget? get body => Column(
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 200,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(burger),
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//               AppButton.backButton,
//             ],
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Card(
//               surfaceTintColor: Colors.white,
//               child: TextFormField(
//                 controller: controller.searchCtrl,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   prefixIcon: Icon(Icons.search),
//                   hintText: "Search",
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: ListView.separated(
//                 itemCount: 16,
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (_, index) => InkWell(
//                   onTap: () => Get.to(() => const FoodDetailScreen()),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Column(
//                           children: [
//                             AppTexts.titleText(
//                               text: "Chicken Burger",
//                               fontWeight: FontWeight.w500,
//                               fontSize: 17,
//                               textAlign: TextAlign.center,
//                             ),
//                             AppTexts.simpleText(
//                               text: "414 Cal. per serving",
//                               fontSize: 10,
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Container(
//                           height: 150,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage(chickenBurger),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             height: 50,
//                             width: 35,
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(16),
//                                 bottomRight: Radius.circular(16),
//                               ),
//                             ),
//                             alignment: Alignment.center,
//                             child: const Icon(
//                               Icons.add_circle_outline_sharp,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 separatorBuilder: (_, index) => const Divider(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
// }
