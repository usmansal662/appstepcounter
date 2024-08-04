import 'package:get/get.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';
import 'package:step_counter/features/get_started/data/gender_enum.dart';
import 'package:step_counter/features/get_started/data/height_enum.dart';

import 'data/weight_enum.dart';

class GetStartedController extends BaseController {
  static final instance = Get.find<GetStartedController>();

  ///* Gender Selection
  Gender gender = Gender.none;

  void updateGender(Gender value) {
    gender = value;
    update();
  }

  ///* AGE
  double userAge = 18;

  void updateAge(double value) {
    userAge = value;
    update();
  }

  ///* Height
  Height height = Height.cm;

  void updateHeight(Height value) {
    height = value;
    if (height == Height.ft) {
      userHeight = 5.2;
    } else {
      userHeight = 160;
    }
    update();
  }

  double userHeight = 160;

  void updateHeightVal(double value) {
    userHeight = value;
    update();
  }

  ///* Weight
  Weight weight = Weight.kg;

  void updateWeight(Weight value) {
    weight = value;
    if (weight == Weight.kg) {
      userWeight = 50;
    } else {
      userWeight = 110;
    }
    update();
  }

  double userWeight = 50;

  void updateWeightVal(double value) {
    userWeight = value;
    update();
  }
}
