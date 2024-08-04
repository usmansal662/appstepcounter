import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/base_controller.dart';
import '../widget/custom_loading.dart';

abstract class BaseView<T extends BaseController> extends GetView<T> {
  const BaseView({super.key});

  bool get isLoading => false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      init: controller,
      initState: initState,
      dispose: disposeState,
      didChangeDependencies: didChangeDependencies,
      builder: (_) {
        return CustomLoading(
          isLoading: isLoading,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBar,
              body: body,
              bottomNavigationBar: bottomNavBar,
              extendBody: extendBody,
              floatingActionButton: floatingActionBtn,
            ),
          ),
        );
      },
    );
  }

  void initState(state) {}

  void disposeState(state) {}

  void didChangeDependencies(state) {}

  Widget? get body;

  bool get extendBody => false;

  Color? get backgroundColor => null;

  String? get title => null;

  PreferredSizeWidget? get appBar => null;

  Widget? get bottomNavBar => null;

  Widget? get floatingActionBtn => null;
}
