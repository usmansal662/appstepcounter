import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:onepref/onepref.dart';
import 'package:step_counter/core/base/controller/base_controller.dart';

import '../../localization/locale_keys.dart';
import '../../utils/snack_bar.dart';

class SubscriptionController extends BaseController {
  static final instance = Get.find<SubscriptionController>();
  bool isLoading = false;

  ///
  InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<dynamic> subscription;

  final Set<String> variants = {
    "com.weeklyremoveadsstepcounter",
    "com.monthlyremoveadsstepcounter",
    "com.yearlyremoveadsstepcounter",
  };

  //
  bool isStoreLoaded = false;
  List<ProductDetails> products = [];

  //
  bool showButton = false;

  void updateButton() {
    showButton = true;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    ///
    initStore();

    //
    subscription = inAppPurchase.purchaseStream.listen((purchaseList) {
      listenToPurchase(purchaseList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      showErrorSnackBar(message: error);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  ///
  listenToPurchase(List<PurchaseDetails> purchaseList) {
    purchaseList.map((purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showSuccessSnackBar(message: getLocale(LocaleKey.pending));
      }
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        try {
          await inAppPurchase.completePurchase(purchaseDetails);
          showSuccessSnackBar(
            message: getLocale(LocaleKey.subscribedSuccessfully),
          );
          OnePref.setRemoveAds(true);
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      if (purchaseDetails.status == PurchaseStatus.restored) {
        try {
          await inAppPurchase.completePurchase(purchaseDetails);
          OnePref.setRemoveAds(true);
          showSuccessSnackBar(
            message: getLocale(LocaleKey.subscribedSuccessfully),
          );
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }

  Future<void> initStore() async {
    isLoading = true;
    update();

    //*
    ProductDetailsResponse response =
        await inAppPurchase.queryProductDetails(variants);

    if (response.error == null) {
      products = response.productDetails;
      isStoreLoaded = true;
      update();
      debugPrint("${response.notFoundIDs}");
    } else {
      debugPrint("${response.error}");
    }

    //*
    isLoading = false;
    update();
  }

  void buy() {
    final PurchaseParam param = PurchaseParam(productDetails: products[1]);
    inAppPurchase.buyNonConsumable(purchaseParam: param);
  }

  void restore() async {
    isLoading = true;
    update();

    await inAppPurchase.restorePurchases();

    //*
    isLoading = false;
    update();
  }

  //*
  void updateSelectedPackage(int value) {
    ProductDetails selectedPackage = products[value];
    products[value] = products[1];
    products[1] = selectedPackage;

    update();
  }

  String getText(int index) {
    String str = '';
    if (products[index].title.toLowerCase().contains('weekly')) {
      str = getLocale(LocaleKey.weekly);
    } else if (products[index].title.toLowerCase().contains('monthly')) {
      str = getLocale(LocaleKey.monthly);
    } else if (products[index].title.toLowerCase().contains('yearly')) {
      str = getLocale(LocaleKey.yearly);
    }
    return str;
  }
}
