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
import 'package:store_app_taav/src/pages/seller/view/view_model/filter_product_tag_model_view.dart';
import 'package:store_app_taav/src/shared/get_products_repository.dart';
import 'package:store_app_taav/src/shared/remember_me_repository.dart';

class SellerController extends GetxController {
  @override
  void onInit() {
    if (args != null) {
      saveArgs();
      saveSellerId();
    }
    getProducts();
    super.onInit();
  }

//save Seller id for add product
  RxString sellerId = RxString("initial");
  void saveSellerId() {
    sellerId.value = args;
  }

//filtering final Values
  Rx<bool> isFilterButtonPressed = false.obs;
  Rx<double> filteringPriceStartValue = Rx(0);
  Rx<double> filteringPriceEndValue = Rx(0);

  RxList<SelectedColorViewModel> filteringDialogSelectedColorList =
      <SelectedColorViewModel>[].obs;

  RxBool isOnAddMode = RxBool(false);

  Rx<Color> dialogLastColorSelected = Rx(Colors.white);

  RxBool isAnyColorSelected = RxBool(true);

  RxList<ProductViewModel> productsList = <ProductViewModel>[].obs;

  RxList<double> productsPriceList = <double>[].obs;

  RxList<FilterProductTagModelView> productsTagsList =
      <FilterProductTagModelView>[].obs;

  // RxList<ProductViewModel> displayProductList = <ProductViewModel>[].obs;
  RxBool isSearchLoading = RxBool(false);
  // RxDouble minValuePrice = RxDouble(0);
  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final dto = RememberMeDto(false);
  final args = Get.arguments;
  final SellerRepository _sellerRepository = SellerRepository();
  final GetProductsRepository _getProductsRepository = GetProductsRepository();
//
  Rx<bool> isSwiched = false.obs;
  Rx<bool> isPageLoading = false.obs;

  Rx<bool> isLoading = false.obs;

  void onClearAllFilterButtonPressed({required BuildContext context}) {
    isFilterButtonPressed.value = false;
    filteringPriceStartValue.value = productsPriceList.first;
    filteringPriceEndValue.value = productsPriceList.last;
    filteringDialogSelectedColorList.value = [];
    productsList.clear();
    getProducts();
    Navigator.of(context).pop();
  }

  void onFilterButtonPressed(BuildContext context) {
    isFilterButtonPressed.value = true;
    // filter Price
    productsList.removeWhere((element) =>
        int.parse(element.price) < filteringPriceStartValue.value.toInt());
    productsList.removeWhere((element) =>
        int.parse(element.price) > filteringPriceEndValue.value.toInt());

    //filter Colors
    List<String> filteringColors = [];
    for (var c in filteringDialogSelectedColorList) {
      filteringColors.add(c.color!.value.toString());
    }
    // if (filteringColors.isNotEmpty) {
    //   if (filteringColors.length < 5) {
    //     for (int a = filteringColors.length; a < 5; a++) {
    //       filteringColors.add("4294967295");
    //     }
    //   }
    // }

    if (filteringColors.isNotEmpty) {
      List<ProductViewModel> removeList = [];

      for (int a = 0; a < productsList.length; a++) {
        for (int b = 0;
            b < productsList[a].color.map((e) => e as String).toList().length;
            b++) {
          if (!filteringColors.every((element) => productsList[a]
              .color
              .map((e) => e as String)
              .toList()
              .contains(element))) {
            removeList.add(productsList[a]);
          }
          // if (!listEquals(
          //     productsList[a].color.map((e) => e as String).toList(),
          //     filteringColors)) {
          //   removeList.add(productsList[a]);
          // }
        }
      }
      for (int c = 0; c < removeList.length; c++) {
        for (int d = 0; d < productsList.length; d++) {
          if (removeList[c].id == productsList[d].id) {
            productsList.removeAt(d);
          }
        }
      }
    }

    //filter tags
    List<String> filterTagsSelected = [];
    List<ProductViewModel> tagsRemoveList = [];
    for (var a in productsTagsList) {
      if (a.isTagCheck == true) {
        filterTagsSelected.add(a.tagLable);
      }
    }
    for (int a = 0; a < productsList.length; a++) {
      if (!filterTagsSelected.every((element) => productsList[a]
          .tag
          .map((e) => e as String)
          .toList()
          .contains(element))) {
        tagsRemoveList.add(productsList[a]);
      }
    }
    for (int c = 0; c < tagsRemoveList.length; c++) {
      for (int d = 0; d < productsList.length; d++) {
        if (tagsRemoveList[c].id == productsList[d].id) {
          productsList.removeAt(d);
        }
      }
    }
    Navigator.of(context).pop();
  }

  void onPopUpMenuRefreshTapped() {
    productsList.clear();
    getProducts();
  }

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
      RouteNames.sellerPageRoute + RouteNames.addProductRoute,
      arguments: sellerId.value,
    );
    if (result != null) {
      //fill it
      // productsList.add(result);
      productsList.clear();
      getProducts();
    }
  }

//

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

    final isActiveDto = ProductDto(
      isActive: isSwiched.value,
      count: productsList[index].count,
      cartCount: productsList[index].cartCount ?? "0",
      cartMode: productsList[index].cartMode ?? false,
    );

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
    final resultOrExeption = await _getProductsRepository.getProducts();
    resultOrExeption.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) => {
        for (var a in right)
          {
            if (a.sellerId! == sellerId.value) {productsList.add(a)}
          },
        // productsList.addAll(right),
        productsPriceList.clear(),
        for (var a in productsList)
          {
            productsPriceList.add(double.tryParse(a.price) ?? 0),
            productsTagsList.clear(),
            for (var b in a.tag)
              {
                productsTagsList.add(
                    FilterProductTagModelView(tagLable: b, isTagCheck: false)),
              }
          },
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

  onEditButtonTapped({required int index}) async {
    var result = await Get.toNamed(
        RouteNames.sellerPageRoute + RouteNames.editProductRoute,
        arguments: productsList[index].id);
    if (result != null) {
      //fill it
      // productsList.add(result);
      productsList.clear();
      getProducts();
    }
  }
}
