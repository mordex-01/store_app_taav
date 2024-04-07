import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/cart/repository/cart_repository.dart';
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/shared/get_products_repository.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    getCarts();
    super.onInit();
  }

  RxList<ProductViewModel> cartsList = <ProductViewModel>[].obs;
  final GetProductsRepository _getProductsRepository = GetProductsRepository();
  final CartRepository _cartRepository = CartRepository();
  Future<void> getCarts() async {
    final resultOrExeption = await _getProductsRepository.getProducts();
    resultOrExeption.fold(
      (left) => null,
      (right) {
        for (var a in right) {
          if (a.cartMode != null) {
            if (a.cartMode == true) {
              cartsList.add(a);
            }
          }
        }
      },
    );
  }

  Future<void> onRightNumberPickerPressed({required int index}) async {
    if (cartsList[index].count != "0") {
      final dto = ProductDto(
          cartMode: cartsList[index].cartMode,
          isActive: cartsList[index].isActive,
          cartCount: (int.parse(cartsList[index].cartCount!) + 1).toString(),
          count: (int.parse(cartsList[index].count) - 1).toString());
      final increeseCount =
          await _cartRepository.patchProduct(dto: dto, id: cartsList[index].id);
      increeseCount.fold((left) => null, (right) {
        cartsList.clear();
        getCarts();
      });
    }
  }

  Future<void> onLeftNumberPickerPressed({required int index}) async {
    if (cartsList[index].cartCount == "1") {
      final dto = ProductDto(
          isActive: cartsList[index].isActive,
          cartMode: false,
          cartCount: "0",
          count: (int.parse(cartsList[index].cartCount!) +
                  int.parse(cartsList[index].count))
              .toString());
      final removeOnDecreeseUnderOne =
          await _cartRepository.patchProduct(dto: dto, id: cartsList[index].id);
      removeOnDecreeseUnderOne.fold((left) => null, (right) {
        cartsList.clear();
        getCarts();
      });
    }
    if (cartsList[index].cartCount != "1" && cartsList.isNotEmpty) {
      final dto = ProductDto(
          cartMode: cartsList[index].cartMode,
          isActive: cartsList[index].isActive,
          cartCount: (int.parse(cartsList[index].cartCount!) - 1).toString(),
          count: (int.parse(cartsList[index].count) + 1).toString());
      final increeseCount =
          await _cartRepository.patchProduct(dto: dto, id: cartsList[index].id);
      increeseCount.fold((left) => null, (right) {
        cartsList.clear();
        getCarts();
      });
    }
  }

  // RxString testText = RxString("initial");
  // final CartRepository _cartsRepository = CartRepository();
  // // RxInt cartItemCount = RxInt(0);
  // RxList<CartViewModel> cartList = <CartViewModel>[].obs;

  // Future<void> onDeleteTapped({required String id}) async {
  //   final resultOrExeption = await _cartsRepository.deleteCart(id: id);
  //   resultOrExeption.fold((left) => null, (right) => {getCarts()});
  // }

  // Future<void> onLeftNumberPickerTapped(
  //     {required int index, required String id}) async {
  //   if (cartList[index].count == "1") {
  //     onDeleteTapped(id: id);
  //   }
  //   final dto = AddToCartDto(
  //       storeCount: (int.parse(cartList[index].storeCount!) + 1).toString(),
  //       productId: cartList[index].productId,
  //       productTitle: cartList[index].productTitle,
  //       price: cartList[index].price,
  //       count: (int.parse(cartList[index].count) - 1).toString());
  //   final resultOrExeption = await _cartsRepository.patchCart(dto: dto, id: id);
  //   await Future.delayed(const Duration(seconds: 1));
  //   resultOrExeption.fold((left) => null, (right) {
  //     getCarts();
  //   });
  // }

  // Future<void> onRightNumberPickerTapped(
  //     {required int index, required String id}) async {
  //   if (int.parse(cartList[index].storeCount!) > 0) {
  //     final dto = AddToCartDto(
  //         storeCount: (int.parse(cartList[index].storeCount!) - 1).toString(),
  //         productId: cartList[index].productId,
  //         productTitle: cartList[index].productTitle,
  //         price: cartList[index].price,
  //         count: (int.parse(cartList[index].count) + 1).toString());
  //     final resultOrExeption =
  //         await _cartsRepository.patchCart(dto: dto, id: id);
  //     await Future.delayed(const Duration(seconds: 1));
  //     resultOrExeption.fold((left) => null, (right) {
  //       getCarts();
  //     });
  //   }
  // }

  // Future<void> getCarts() async {
  //   final resultOrExeption = await _cartsRepository.getCarts();
  //   resultOrExeption.fold(
  //       (left) => Get.showSnackbar(
  //             WidgetUtils.myCustomSnackBar(
  //                 messageText: left, backgroundColor: Colors.redAccent),
  //           ), (right) {
  //     cartList.clear();
  //     cartList.addAll(right);
  //   });
  // }
}
