import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/addproduct/model/add_product_dto.dart';
import 'package:store_app_taav/src/pages/addproduct/repository/add_product_repository.dart';

class AddProductController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final AddProductRepository _addProductRepository = AddProductRepository();
  final formKey = GlobalKey<FormState>();

  var bytes = Uint8List(0).obs;

  Future<Uint8List?> galleryImagePicker() async {
    ImagePicker picker = ImagePicker();

    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );

    if (file != null) {
      return await file.readAsBytes(); // convert into Uint8List.
    }
    return null;
  }

  Future getImage() async {
    final Uint8List? image = await galleryImagePicker();

    if (image != null) {
      bytes.value = image;
    }
  }

  Future<void> addProduct() async {
    final dto = AddProductDto(
        title: titleController.text,
        description: descriptionController.text,
        price: priceController.text,
        isActive: true);
    final resultOrExeption = await _addProductRepository.addProduct(dto: dto);
    resultOrExeption.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) => {
        Get.offAndToNamed(RouteNames.sellerPageRoute, result: right),
        Get.showSnackbar(
          WidgetUtils.myCustomSnackBar(
              messageText: "${right.title} added",
              backgroundColor: Colors.greenAccent),
        ),
      },
    );
  }

  onAddButtonTapped() async {
    await addProduct();
  }
}
