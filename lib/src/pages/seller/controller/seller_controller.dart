import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/pages/seller/repository/seller_repository.dart';
import 'package:store_app_taav/src/pages/seller/view/selected_color_view_model.dart';
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

  RxBool isOnAddMode = RxBool(false);

  RxList<SelectedColorViewModel> dialogSelectedColorList =
      <SelectedColorViewModel>[].obs;

  Rx<Color> dialogLastColorSelected = Rx(Colors.white);

  RxBool isAnyColorSelected = RxBool(true);

  RxList<ProductViewModel> productsList = <ProductViewModel>[].obs;

  RxList<double> productsPriceList = <double>[].obs;

  RxList<ProductViewModel> displayProductList = <ProductViewModel>[].obs;
  RxBool isSearchLoading = RxBool(false);
  RxDouble minValuePrice = RxDouble(0);
  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final dto = RememberMeDto(false);
  final args = Get.arguments;
  final SellerRepository _sellerRepository = SellerRepository();
//

  void pickColor(
          {required BuildContext context,
          required Widget buildColorPicker,
          required void Function()? onSelectPressed}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Pick Your Color"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildColorPicker,
              TextButton(
                onPressed: onSelectPressed,
                child: const Text(
                  "Select",
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
        ),
      );

  onSearchTextChanged(String text) {
    if (text.isEmpty) {
      productsList.clear();
      getProducts();
    }

    isSearchLoading.value = true;
    productsList.removeWhere(
      (element) =>
          !element.title.contains(text) &&
          !element.price.contains(text) &&
          !element.description.contains(text),
    );
    // for (var a in productsList) {
    //   if (!a.title.contains(text)) {
    //     productsList.remove(a);
    //   }
    // }
    // if (element.title.contains(text) || element.description.contains(text)) {
    //   displayProductList.add(element);
    // }
  }

//on add button Tapped
  onAddButtonTapped() async {
    var result = await Get.toNamed(
        RouteNames.sellerPageRoute + RouteNames.addProductRoute);
    if (result != null) {
      //fill it
      // productsList.add(result);
      productsList.clear();
      getProducts();
    }
  }

//
  Rx<bool> isSwiched = false.obs;
  Rx<bool> isPageLoading = false.obs;

  Rx<bool> isLoading = false.obs;

  Future<void> getIsActive({required String id}) async {
    final resultOrExeption = await _sellerRepository.getIsActive(id: id);
    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => {
              // isSwiched.value = right.isActive
              isSwiched.value = right.isActive,
            });
    // isLoading.value = false;
  }

  Future<void> toggleIsActive(String id, int index) async {
    isPageLoading.value = true;
    // isLoading.value = true;
    // await getIsActive(id: id);
    // if (mybool.value == false) {
    //   mybool.value = true;
    // }
    // if (mybool.value == true) {
    //   mybool.value = false;
    // }
    isLoading.value = true;

    await getIsActive(id: id);

    if (isSwiched.value) {
      isSwiched.value = false;
    } else {
      isSwiched.value = true;
    }

    final isActiveDto = ProductDto(isActive: isSwiched.value);

    final resultOrExeption =
        await _sellerRepository.toggleIsActive(id: id, dto: isActiveDto);
    // isLoading.value = false;

    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => {
              // isSwiched.value = right.isActive,

              productsList[index].isActive = !productsList[index].isActive,
              Get.showSnackbar(WidgetUtils.myCustomSnackBar(
                  messageText: "${right.title} Changed Active Mode",
                  backgroundColor: Colors.greenAccent))
            });
    await getIsActive(id: id);
    isLoading.value = false;
    isPageLoading.value = false;
  }
//

  Future<void> getProducts() async {
    final resultOrExeption = await _sellerRepository.getProducts();
    resultOrExeption.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) => {
        productsList.addAll(right),
        for (var a in productsList)
          {productsPriceList.add(double.tryParse(a.price) ?? 0)},
        productsPriceList..sort(),
      },
    );
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
