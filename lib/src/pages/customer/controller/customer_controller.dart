import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/cart/repository/cart_repository.dart';
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
    getCount();
    // getCarts();
    super.onInit();
  }

  RxBool isLanguage = false.obs;
  // final CartRepository _cartRepository = CartRepository();
  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final GetProductsRepository _getProductsRepository = GetProductsRepository();
  final CartRepository _cartRepositor = CartRepository();
  RxList<ProductViewModel> productsList = <ProductViewModel>[].obs;
  RxInt cartItemCount = RxInt(0);
  RxString detailsResultProductId = RxString("initial");
  //
  RxString customeId = RxString("initial");

  final dto = RememberMeDto(false);
  final args = Get.arguments;
  RxInt cartCount = RxInt(0);

  Future<void> onCartIconTapped() async {
    //--//--
    await Get.toNamed(RouteNames.customerPageRoute + RouteNames.cartPageRoute);
    cartCount.value = 0;
    getCount();
    // getProducts();
  }

//
//
  Future<void> getCount() async {
    final getCarts = await _cartRepositor.getCart();
    getCarts.fold((left) => null, (right) {
      for (var a in right) {
        if (a.customerId == customeId.value) {
          cartCount.value += int.parse(a.itemCount);
        }
      }
    });
  }

  // Future<void> getCarts() async {
  //   int counts = 0;
  //   final resultOrExeption = await _cartRepository.getCarts();
  //   resultOrExeption.fold(
  //       (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
  //           messageText: "cant get carts on customer page",
  //           backgroundColor: Colors.redAccent)), (right) {
  //     for (var a in right) {
  //       counts += (int.parse(a.count));
  //     }
  //     cartItemCount.value = counts;
  //   });
  // }

  Future<void> getProducts() async {
    int counts = 0;
    final resultOrExeption = await _getProductsRepository.getProducts();
    resultOrExeption.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) {
        productsList.clear();
        for (var product in right) {
          //bool is CartMode
          if (product.cartMode != null) {
            if (product.cartMode!) {
              counts += int.parse(product.cartCount!);
            }
          }
          if (product.isActive == true) {
            productsList.add(product);
          }
        }
        cartItemCount.value = counts;
      },
    );
  }

  Future<void> saveArgs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("myUserId", args);
    //
    customeId.value = pref.getString("myUserId")!;
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

  Future<void> goToDetailsPage({required int index}) async {
    // var result =

    await Get.toNamed(
      RouteNames.customerPageRoute + RouteNames.detailsPageRoute,
      parameters: {
        "product-id": productsList[index].id,
        "count": productsList[index].count
      },
    );
    cartCount.value = 0;
    getCount();
    // if (result != null) {
    //   print(result);
    //   cartCount.value + int.parse(result);

    //   // cartItemCount.value += int.parse(result);
    //   // getProducts();
    //   // getCarts();
    // }
  }

  void goToCart() {
    Get.toNamed(RouteNames.customerPageRoute + RouteNames.cartPageRoute);
  }
}
