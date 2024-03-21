import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/pages/seller/repository/seller_repository.dart';
import 'package:store_app_taav/src/shared/remember_me_repository.dart';

class SellerController extends GetxController {
  @override
  void onInit() {
    if (args != null) {
      saveArgs();
    }
    getProducts();
    super.onInit();
  }

  RxList<ProductViewModel> productsList = <ProductViewModel>[].obs;
  RxBool isSwiched = RxBool(false);
  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final dto = RememberMeDto(false);
  final args = Get.arguments;
  final SellerRepository _sellerRepository = SellerRepository();
  Future<void> toggleIsActive(String id) async {
    isSwiched.value = !isSwiched.value;
    final isActiveDto = ProductDto(isActive: isSwiched.value);

    final resultOrExeption =
        _sellerRepository.toggleIsActive(id: id, dto: isActiveDto);
    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: "${right.id} toggled",
            backgroundColor: Colors.greenAccent)));
  }

  Future<void> getProducts() async {
    final resultOrExeption = await _sellerRepository.getProducts();
    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => {productsList.addAll(right)});
  }

  Future<void> saveArgs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("myUserId", args);
  }

  // Future<void> deleteArgs() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.remove("myUserId");
  // }

  Future<void> onBackTapped() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("rememberMe", false);
    String userId = pref.getString("myUserId") as String;
    final resultOrExeption = await _rememberMeRepository.patchRememberMe(
        route: "/seller", id: userId, dto: dto);
    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => null);
    bool? isSeller = pref.getBool("isSeller");
    bool? isCustomer = pref.getBool("isCustomer");
    if (isSeller != null) {
      if (isSeller) {
        pref.setBool("isSeller", false);
      }
    }
    if (isCustomer != null) {
      if (isCustomer) {
        pref.setBool("isCustomer", false);
      }
    }
    Get.offAllNamed(RouteNames.loginPageRoute);
  }
}
