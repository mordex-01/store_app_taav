import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/cart/repository/cart_repository.dart';
import 'package:store_app_taav/src/pages/details/model/add_to_cart_dto.dart';
import 'package:store_app_taav/src/shared/cart_view_model.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    getCarts();
    super.onInit();
  }

  RxString testText = RxString("initial");
  final CartRepository _cartsRepository = CartRepository();
  // RxInt cartItemCount = RxInt(0);
  RxList<CartViewModel> cartList = <CartViewModel>[].obs;

  Future<void> onDeleteTapped({required String id}) async {
    final resultOrExeption = await _cartsRepository.deleteCart(id: id);
    resultOrExeption.fold((left) => null, (right) => {getCarts()});
  }

  Future<void> onLeftNumberPickerTapped(
      {required int index, required String id}) async {
    if (cartList[index].count == "1") {
      onDeleteTapped(id: id);
    }
    final dto = AddToCartDto(
        storeCount: (int.parse(cartList[index].storeCount!) + 1).toString(),
        productId: cartList[index].productId,
        productTitle: cartList[index].productTitle,
        price: cartList[index].price,
        count: (int.parse(cartList[index].count) - 1).toString());
    final resultOrExeption = await _cartsRepository.patchCart(dto: dto, id: id);
    await Future.delayed(const Duration(seconds: 1));
    resultOrExeption.fold((left) => null, (right) {
      getCarts();
    });
  }

  Future<void> onRightNumberPickerTapped(
      {required int index, required String id}) async {
    if (int.parse(cartList[index].storeCount!) > 0) {
      final dto = AddToCartDto(
          storeCount: (int.parse(cartList[index].storeCount!) - 1).toString(),
          productId: cartList[index].productId,
          productTitle: cartList[index].productTitle,
          price: cartList[index].price,
          count: (int.parse(cartList[index].count) + 1).toString());
      final resultOrExeption =
          await _cartsRepository.patchCart(dto: dto, id: id);
      await Future.delayed(const Duration(seconds: 1));
      resultOrExeption.fold((left) => null, (right) {
        getCarts();
      });
    }
  }

  Future<void> getCarts() async {
    final resultOrExeption = await _cartsRepository.getCarts();
    resultOrExeption.fold(
        (left) => Get.showSnackbar(
              WidgetUtils.myCustomSnackBar(
                  messageText: left, backgroundColor: Colors.redAccent),
            ), (right) {
      cartList.clear();
      cartList.addAll(right);
    });
  }
}
