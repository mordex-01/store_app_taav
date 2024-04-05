import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';
import 'package:store_app_taav/src/shared/get_products_repository.dart';

class DetailsController extends GetxController {
  var prams = Get.parameters;

  @override
  void onInit() {
    getProductById(prams['product-id']!);
    super.onInit();
  }

  final GetProductsRepository _getProductsRepository = GetProductsRepository();
  RxList<ProductViewModel> myProductsList = <ProductViewModel>[].obs;

  Rx<Widget> image = Rx(Image.asset("assets/no-image-icon.png"));
  RxString productTitle = RxString("initial");
  RxString productDescription = RxString("initial");
  RxString productPrice = RxString("initial");
  Rx<Color> color1 = Rx(Colors.white);
  Rx<Color> color2 = Rx(Colors.white);
  Rx<Color> color3 = Rx(Colors.white);
  Rx<Color> color4 = Rx(Colors.white);
  Rx<Color> color5 = Rx(Colors.white);
  RxList<String> productTags = <String>[].obs;

  Future<void> getProductById(String id) async {
    final resultOrExeption = await _getProductsRepository.getProductById(id);
    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)), (right) {
      if (right.image != "") {
        image.value =
            Image.memory(Uint8List.fromList(base64Decode(right.image!)));
      }
      productTitle.value = right.title;
      productDescription.value = right.description;
      productPrice.value = right.price;
      color1.value = Color(int.parse(right.color[0]));
      color2.value = Color(int.parse(right.color[1]));
      color3.value = Color(int.parse(right.color[2]));
      color4.value = Color(int.parse(right.color[3]));
      color5.value = Color(int.parse(right.color[4]));
      productTags.addAll(right.tag.map((e) => e as String).toList());
    });
  }
}
