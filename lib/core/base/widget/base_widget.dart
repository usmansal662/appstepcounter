import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/base_controller.dart';

abstract class BaseWidget<T extends BaseController> extends GetWidget<T> {
  const BaseWidget({super.key});

  Widget get child;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        return child;
      },
    );
  }

  TextDirection get textDirection => Directionality.of(Get.context!);
}
