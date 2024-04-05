import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/shared/get_products_repository.dart';
import 'package:store_app_taav/src/shared/remember_me_repository.dart';

class CustomerController extends GetxController {
  @override
  void onInit() {
    if (args != null) {
      saveArgs();
    }
    getProducts();
    super.onInit();
  }

  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final GetProductsRepository _getProductsRepository = GetProductsRepository();
  RxList<ProductViewModel> productsList = <ProductViewModel>[].obs;

  final dto = RememberMeDto(false);
  final args = Get.arguments;

  Future<void> getProducts() async {
    final resultOrExeption = await _getProductsRepository.getProducts();
    resultOrExeption.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) {
        for (var product in right) {
          if (product.isActive == true) {
            productsList.add(product);
          }
        }
      },
    );
  }

  Future<void> saveArgs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("myUserId", args);
  }

  Future<void> onBackTapped() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("rememberMe", false);
    String userId = pref.getString("myUserId") as String;
    final resultOrExeption = await _rememberMeRepository.patchRememberMe(
        route: "/customer", id: userId, dto: dto);
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

  void goToDetailsPage({required int index}) {
    Get.toNamed(RouteNames.customerPageRoute + RouteNames.detailsPageRoute,
        parameters: {"product-id": productsList[index].id});
  }
}
