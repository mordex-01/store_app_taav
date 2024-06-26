import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/cart/model/cart_dto.dart';
import 'package:store_app_taav/src/pages/cart/repository/cart_repository.dart';
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/shared/get_products_repository.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    setCustomer();
    getCarts();
    super.onInit();
  }

  RxList<ProductViewModel> cartsList = <ProductViewModel>[].obs;
  RxList<ProductViewModel> trueList = <ProductViewModel>[].obs;
  RxString lastCartCount = RxString("initial");
  final GetProductsRepository _getProductsRepository = GetProductsRepository();
  final CartRepository _cartRepository = CartRepository();

  RxInt totalPrice = RxInt(0);
//get Customer
  RxString customerId = RxString("initial");
  Future<void> setCustomer() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    customerId.value = pref.getString("myUserId")!;
    print(customerId.value);
  }

  // void countTotalPrice() async {
  //   totalPrice.value = 0;
  //   late int total = 0;
  //   for (var a in trueList) {
  //     total = int.parse(a.cartCount!) * int.parse(a.price);
  //   }
  //   totalPrice.value += total;
  // }

  Future<void> getCarts() async {
    totalPrice.value = 0;
    cartsList.clear();
    trueList.clear();

    final getCart = await _cartRepository.getCart();
    getCart.fold((left) => print(left), (right) async {
      for (var a in right) {
        if (a.customerId == customerId.value) {
          late String productId;
          productId = a.productId;
          final resultOrExeption = await _getProductsRepository.getProducts();
          resultOrExeption.fold((left) => null, (right) {
            for (var b in right) {
              if (b.id == productId) {
                b.cartCount = a.itemCount;
                trueList.add(b);
                totalPrice.value +=
                    int.parse(b.cartCount!) * int.parse(b.price);
              }
            }
          });
        }
      }
    });
  }

  Future<void> onDeleteButtonPressed({required int index}) async {
    final getCart = await _cartRepository.getCart();
    getCart.fold((left) => null, (right) async {
      for (var a in right) {
        if (a.customerId == customerId.value &&
            trueList[index].id == a.productId) {
          final deleteCart = await _cartRepository.deleteCart(id: a.id!);
          deleteCart.fold((left) => null, (right) async {
            final getProduct =
                await _getProductsRepository.getProductById(a.productId);
            getProduct.fold((left) => null, (right) async {
              final patchProduct = await _cartRepository.patchProduct(
                  dto: ProductDto(
                      isActive: true,
                      cartMode: true,
                      count: (int.parse(right.count) + int.parse(a.itemCount))
                          .toString(),
                      cartCount:
                          (int.parse(right.cartCount!) - int.parse(a.itemCount))
                              .toString()),
                  id: a.productId);
              patchProduct.fold(
                  (left) => null, (right) => trueList.removeAt(index));
            });
          });
        }
      }
    });
  }

  Future<void> onRightNumberPickerPressed({required int index}) async {
    final getCartss = await _cartRepository.getCart();
    getCartss.fold((left) => null, (right) async {
      for (var a in right) {
        if (a.customerId == customerId.value &&
            a.productId == trueList[index].id) {
          final increeseCart = await _cartRepository.editCart(
              id: a.id!,
              dto: CartDto(
                  customerId: customerId.value,
                  productId: a.productId,
                  itemCount: (int.parse(a.itemCount) + 1).toString()));
          increeseCart.fold((left) => null, (right) async {
            final getProductById =
                await _getProductsRepository.getProductById(a.productId);
            getProductById.fold((left) => null, (right) async {
              final increeseCartCount = await _cartRepository.patchProduct(
                dto: ProductDto(
                    cartMode: true,
                    count: (int.parse(right.count) - 1).toString(),
                    isActive: true,
                    cartCount: (int.parse(right.cartCount!) + 1).toString()),
                id: a.productId,
              );
              increeseCartCount.fold((left) => null, (right) => getCarts());
            });
          });
        }
      }
    });
    // if (trueList[index].count != "0") {
    //   final dto = ProductDto(
    //       isActive: trueList[index].isActive,
    //       cartMode: true,
    //       count: (int.parse(trueList[index].count) - 1).toString(),
    //       cartCount: (int.parse(lastCartCount.value) + 1).toString());
    //   final increeseCount =
    //       await _cartRepository.patchProduct(dto: dto, id: trueList[index].id);
    //   increeseCount.fold((left) => null, (right) => null);
    //   final getCarts = await _cartRepository.getCart();
    //   getCarts.fold((left) => null, (right) async {
    //     for (var a in right) {
    //       if (a.customerId == customerId.value &&
    //           trueList[index].id == a.productId) {
    //         final dto = CartDto(
    //             customerId: customerId.value,
    //             productId: a.productId,
    //             itemCount: (int.parse(a.itemCount) + 1).toString());
    //         final increeseCartCount =
    //             await _cartRepository.editCart(id: a.id!, dto: dto);
    //         increeseCartCount.fold((left) => null, (right) => null);
    //       }
    //     }
    //   });
    // }
  }

  Future<void> onLeftNumberPickerPressed({required int index}) async {
    if (trueList[index].cartCount == "1") {
      final getCart = await _cartRepository.getCart();
      getCart.fold((left) => null, (right) async {
        for (var a in right) {
          if (a.customerId == customerId.value &&
              trueList[index].id == a.productId) {
            final deleteCart = await _cartRepository.deleteCart(id: a.id!);
            deleteCart.fold((left) => null, (right) async {
              final getProduct =
                  await _getProductsRepository.getProductById(a.productId);
              getProduct.fold((left) => null, (right) async {
                final patchProduct = await _cartRepository.patchProduct(
                    dto: ProductDto(
                        isActive: true,
                        cartMode: true,
                        count: (int.parse(right.count) + int.parse(a.itemCount))
                            .toString(),
                        cartCount: (int.parse(right.cartCount!) -
                                int.parse(a.itemCount))
                            .toString()),
                    id: a.productId);
                patchProduct.fold(
                    (left) => null, (right) => trueList.removeAt(index));
              });
            });
          }
        }
      });
    }
    final getCartss = await _cartRepository.getCart();
    getCartss.fold((left) => null, (right) async {
      for (var a in right) {
        if (a.customerId == customerId.value &&
            a.productId == trueList[index].id) {
          final increeseCart = await _cartRepository.editCart(
              id: a.id!,
              dto: CartDto(
                  customerId: customerId.value,
                  productId: a.productId,
                  itemCount: (int.parse(a.itemCount) - 1).toString()));
          increeseCart.fold((left) => null, (right) async {
            final getProductById =
                await _getProductsRepository.getProductById(a.productId);
            getProductById.fold((left) => null, (right) async {
              final increeseCartCount = await _cartRepository.patchProduct(
                dto: ProductDto(
                    cartMode: true,
                    count: (int.parse(right.count) + 1).toString(),
                    isActive: true,
                    cartCount: (int.parse(right.cartCount!) - 1).toString()),
                id: a.productId,
              );
              increeseCartCount.fold((left) => null, (right) => getCarts());
            });
          });
        }
      }
    });
    // if (trueList[index].cartCount != "1") {
    //   final dto = ProductDto(
    //       isActive: trueList[index].isActive,
    //       cartMode: true,
    //       count: (int.parse(trueList[index].count) + 1).toString(),
    //       cartCount: (int.parse(lastCartCount.value) - 1).toString());
    //   final decreeseCount =
    //       await _cartRepository.patchProduct(dto: dto, id: trueList[index].id);
    //   decreeseCount.fold((left) => null, (right) => null);
    //   final getCarts = await _cartRepository.getCart();
    //   getCarts.fold((left) => null, (right) async {
    //     for (var a in right) {
    //       if (a.customerId == customerId.value &&
    //           trueList[index].id == a.productId) {
    //         final dto = CartDto(
    //             customerId: customerId.value,
    //             productId: a.productId,
    //             itemCount: (int.parse(a.itemCount) - 1).toString());
    //         final increeseCartCount =
    //             await _cartRepository.editCart(id: a.id!, dto: dto);
    //         increeseCartCount.fold((left) => null, (right) => null);
    //       }
    //     }
    //   });
    // }
    // getCarts();
    // if (cartsList[index].cartCount == "1") {
    //   final dto = ProductDto(
    //       isActive: cartsList[index].isActive,
    //       cartMode: false,
    //       cartCount: "0",
    //       count: (int.parse(cartsList[index].cartCount!) +
    //               int.parse(cartsList[index].count))
    //           .toString());
    //   final removeOnDecreeseUnderOne =
    //       await _cartRepository.patchProduct(dto: dto, id: cartsList[index].id);
    //   removeOnDecreeseUnderOne.fold((left) => null, (right) {
    //     cartsList.removeAt(index);
    //     getCarts();
    //   });
    // }
    // if (cartsList[index].cartCount != "1" && cartsList.isNotEmpty) {
    //   final dto = ProductDto(
    //       cartMode: cartsList[index].cartMode,
    //       isActive: cartsList[index].isActive,
    //       cartCount: (int.parse(cartsList[index].cartCount!) - 1).toString(),
    //       count: (int.parse(cartsList[index].count) + 1).toString());
    //   final decreeseCount =
    //       await _cartRepository.patchProduct(dto: dto, id: cartsList[index].id);
    //   await Future.delayed(const Duration(seconds: 1));
    //   decreeseCount.fold((left) => null, (right) {
    //     cartsList.clear();
    //     getCarts();
    //   });
    // }
    // countTotalPrice();
  }

  void onBackButtonPressed() {
    cartsList.clear();
    trueList.clear();
    int count = 0;
    for (var a in cartsList) {
      count += int.parse(a.cartCount!);
    }
    Get.back(result: count);
  }

  Future<void> onPaymentButtonPressed() async {
    for (var a in trueList) {
      final getCarts = await _cartRepository.getCart();
      getCarts.fold((left) => null, (right) async {
        for (var b in right) {
          if (b.productId == a.id && b.customerId == customerId.value) {
            final deleteCart = await _cartRepository.deleteCart(id: b.id!);
            deleteCart.fold((left) => null, (right) => null);
          }
        }
      });
      final dto = ProductDto(
          isActive: true, cartCount: "0", cartMode: false, count: a.count);
      final paymantPatch =
          await _cartRepository.patchProduct(dto: dto, id: a.id);
      paymantPatch.fold(
          (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
              messageText: left, backgroundColor: Colors.redAccent)), (right) {
        Get.back();
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
