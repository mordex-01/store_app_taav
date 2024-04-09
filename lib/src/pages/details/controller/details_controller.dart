import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/details/repository/details_repository.dart';
import 'package:store_app_taav/src/pages/seller/model/product_dto.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/shared/get_products_repository.dart';

class DetailsController extends GetxController {
  var prams = Get.parameters;
  @override
  void onReady() {
    getProductById(id: prams['product-id']!);
    super.onReady();
  }

//gereftim
  final GetProductsRepository _getProductsRepository = GetProductsRepository();
  final Rx<ProductViewModel> myProduct = Rx(ProductViewModel(
    image: "",
    id: "id",
    title: "title",
    description: "description",
    price: "price",
    count: "0",
    isActive: true,
    color: [],
    tag: [],
  ));
  //start
  RxInt middleText = RxInt(1);

  Future<void> getProductById({required String id}) async {
    final getProductByid = await _getProductsRepository.getProductById(id);
    getProductByid.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => myProduct.value = right);
  }

  void onLeftnumberPickerPressed() {
    if (middleText.value > 1) {
      middleText.value--;
    }
  }

  void onRightnumberPickerPressed() {
    if (middleText.value < int.parse(myProduct.value.count)) {
      middleText.value++;
    }
  }

  final DetailsRepository _detailsRepository = DetailsRepository();

  Future<void> onAddButtonPressed({required String id}) async {
    final dto = ProductDto(
        isActive: myProduct.value.isActive,
        cartCount: myProduct.value.cartCount != null
            ? (int.parse(myProduct.value.cartCount!) + middleText.value)
                .toString()
            : middleText.value.toString(),
        cartMode: true,
        count:
            (int.parse(myProduct.value.count) - middleText.value).toString());
    final decreeseOrExeption =
        await _detailsRepository.decreeseCount(id: id, dto: dto);
    decreeseOrExeption.fold((left) => null,
        (right) => Get.back(result: middleText.value.toString()));
  }
  //show
}



// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:either_dart/either.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
// import 'package:store_app_taav/src/pages/cart/repository/cart_repository.dart';
// import 'package:store_app_taav/src/pages/details/model/add_to_cart_dto.dart';
// import 'package:store_app_taav/src/pages/details/repository/details_repository.dart';
// import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
// import 'package:store_app_taav/src/shared/cart_view_model.dart';
// import 'package:store_app_taav/src/shared/get_products_repository.dart';

// class DetailsController extends GetxController {
//   var prams = Get.parameters;

//   // @override
//   // void onInit() {
//   //   super.onInit();
//   // }

//   @override
//   void onReady() {
//     getProductById(prams['product-id']!);
//     addAlreadyExestedCarts();
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     productStoreCount.value = "0";
//     super.onClose();
//   }

//   final GetProductsRepository _getProductsRepository = GetProductsRepository();
//   final DetailsRepository _detailsRepository = DetailsRepository();
//   final CartRepository _cartRepository = CartRepository();
//   RxList<ProductViewModel> myProductsList = <ProductViewModel>[].obs;
//   RxList<CartViewModel> cartsList = <CartViewModel>[].obs;
//   Rx<Widget> image = Rx(Image.asset("assets/no-image-icon.png"));
//   RxString productTitle = RxString("initial");
//   RxString productDescription = RxString("initial");
//   RxString productPrice = RxString("initial");
//   Rx<Color> color1 = Rx(Colors.white);
//   Rx<Color> color2 = Rx(Colors.white);
//   Rx<Color> color3 = Rx(Colors.white);
//   Rx<Color> color4 = Rx(Colors.white);
//   Rx<Color> color5 = Rx(Colors.white);
//   RxList<String> productTags = <String>[].obs;
//   RxString productStoreCount = RxString("0");
//   // Rx<bool> isStoreCountSend = false.obs;
//   RxInt productItemCount = RxInt(1);
//   RxInt initialStoreCount = RxInt(0);
//   RxInt initialItemCount = RxInt(0);
//   RxString productId = RxString("initial");
//   Rx<bool> isCartNew = false.obs;

//   Future<void> getProductById(String id) async {
//     final resultOrExeption = await _getProductsRepository.getProductById(id);
//     final resultOrExeptionCart = await _cartRepository.getCarts();
//     resultOrExeption.fold(
//         (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//             messageText: left, backgroundColor: Colors.redAccent)), (right) {
//       if (right.image != "") {
//         image.value =
//             Image.memory(Uint8List.fromList(base64Decode(right.image!)));
//       }
//       productTitle.value = right.title;
//       productDescription.value = right.description;
//       productPrice.value = right.price;
//       color1.value = Color(int.parse(right.color[0]));
//       color2.value = Color(int.parse(right.color[1]));
//       color3.value = Color(int.parse(right.color[2]));
//       color4.value = Color(int.parse(right.color[3]));
//       color5.value = Color(int.parse(right.color[4]));
//       productTags.addAll(right.tag.map((e) => e as String).toList());
//       productId.value = right.id;
//       if (productStoreCount.value != "0" && initialItemCount.value != 0) {
//         initialItemCount.value = int.parse(right.count);
//       }
//       //
//     });
//     resultOrExeptionCart.fold(
//       (left) => print("left"),
//       (right) {
//         for (var a in right) {
//           if (a.storeCount == "0") {
//             productStoreCount.value = "0";
//             //
//             initialItemCount.value = 0;
//             // isStoreCountSend.value = true;
//           } else {
//             productStoreCount.value = a.storeCount!;
//           }
//         }
//       },
//     );
//   }

//   Future<void> addAlreadyExestedCarts() async {
//     final resoltOrExeption = await _cartRepository.getCarts();
//     resoltOrExeption.fold(
//         (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//             messageText: left, backgroundColor: Colors.redAccent)),
//         (right) => {
//               cartsList.addAll(right),
//             });
//   }

//   Future<void> onAddToCart() async {
//     final dto = AddToCartDto(
//         storeCount:
//             (int.parse(productStoreCount.value) - productItemCount.value)
//                 .toString(),
//         productId: productId.value,
//         productTitle: productTitle.value,
//         price: productPrice.value,
//         count: productItemCount.value.toString());
//     if (cartsList.isEmpty) {
//       // isStoreCountSend.value = true;
//       final resultOrExeption = await _detailsRepository.addToCart(dto: dto);
//       resultOrExeption.fold(
//         (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//             messageText: left, backgroundColor: Colors.redAccent)),
//         (right) => {
//           Get.back(
//               result: {"count": productItemCount.value, "id": productId.value}),
//           Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//               messageText: "${right.productTitle} added to Cart",
//               backgroundColor: Colors.greenAccent)),
//         },
//       );
//     }
//     if (cartsList.isNotEmpty) {
//       // isStoreCountSend.value = true;
//       isCartNew.value = true;
//       for (var a in cartsList) {
//         if (a.productId == productId.value) {
//           final dto = AddToCartDto(
//               //
//               storeCount: productStoreCount.value,
//               productId: productId.value,
//               productTitle: productTitle.value,
//               price: productPrice.value,
//               count: (int.parse(a.count) + productItemCount.value).toString());
//           final resultOrExeption =
//               _detailsRepository.patchCart(dto: dto, id: a.id);
//           resultOrExeption.fold(
//               (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//                   messageText: left, backgroundColor: Colors.redAccent)),
//               (right) => {
//                     cartsList.clear(),
//                     addAlreadyExestedCarts(),
//                     Get.back(result: {
//                       "count": productItemCount.value,
//                       "id": productId.value
//                     }, canPop: true),
//                   });
//           isCartNew.value = false;
//         }
//       }
//     }
//     if (isCartNew.value) {
//       // isStoreCountSend.value = true;
//       isCartNew.value = false;
//       final dto = AddToCartDto(
//           storeCount:
//               (int.parse(productStoreCount.value) - productItemCount.value)
//                   .toString(),
//           productId: productId.value,
//           productTitle: productTitle.value,
//           price: productPrice.value,
//           count: productItemCount.value.toString());
//       final resultOrExeption = await _detailsRepository.addToCart(dto: dto);
//       resultOrExeption.fold(
//         (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//             messageText: left, backgroundColor: Colors.redAccent)),
//         (right) => {
//           Get.back(
//               result: {"count": productItemCount.value, "id": productId.value}),
//           Get.showSnackbar(WidgetUtils.myCustomSnackBar(
//               messageText: "${right.productTitle} added to Cart",
//               backgroundColor: Colors.greenAccent)),
//         },
//       );
//     }
//   }

//   void onNumberPickerLeftButtonTapped() {
//     if (productItemCount.value > 1) {
//       productItemCount.value--;
//     }
//   }

//   void onNumberPickerRightButtonTapped() {
//     if (productItemCount.value < initialItemCount.value) {
//       productItemCount.value++;
//     }
//   }
// }
