import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/addproduct/model/add_product_dto.dart';
import 'package:store_app_taav/src/pages/addproduct/repository/add_product_repository.dart';

class AddProductController extends GetxController {
  @override
  void onInit() {
    if (args != null) {
      setSellerId();
    }
    super.onInit();
  }

  var args = Get.arguments;
  //save Seller Id for add to Dto
  RxString sellerId = RxString("initial");
  void setSellerId() {
    sellerId.value = args;
    print(sellerId.value);
  }

  RxList<String> tags = <String>[].obs;

  Rx<Color> color1 = Rx(Colors.white);
  Rx<Color> color2 = Rx(Colors.white);
  Rx<Color> color3 = Rx(Colors.white);
  Rx<Color> color4 = Rx(Colors.white);
  Rx<Color> color5 = Rx(Colors.white);

  RxBool isColorSelected1 = RxBool(false);
  RxBool isColorSelected2 = RxBool(false);
  RxBool isColorSelected3 = RxBool(false);
  RxBool isColorSelected4 = RxBool(false);
  RxBool isColorSelected5 = RxBool(false);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController tagTextFieldController = TextEditingController();
  //
  final AddProductRepository _addProductRepository = AddProductRepository();
  final ScrollController tagsScrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  final addTagsTextFieldFormKey = GlobalKey<FormState>();
  var bytes = Uint8List(0).obs;
  RxList addAllTags = [].obs;
  RxList<String> allTags = <String>[].obs;
  RxBool tagTextFielldisTapped = false.obs;

  Future<void> getProductsTag() async {
    final resoltOrExeption = await _addProductRepository.getProducts();
    resoltOrExeption.fold(
      (left) => null,
      (right) {
        addAllTags.clear();
        for (int j = 0; j < right.length; j++) {
          if (right[j].tag.isNotEmpty) {
            addAllTags.add(right[j].tag);
          }
        }
        for (var a in addAllTags) {
          for (var b in a) {
            allTags.add(b);
          }
        }
      },
    );
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
      sellerId: sellerId.value,
      tag: tags,
      color: [
        color1.value.value.toString(),
        color2.value.value.toString(),
        color3.value.value.toString(),
        color4.value.value.toString(),
        color5.value.value.toString()
      ],
      title: titleController.text,
      description: descriptionController.text,
      price: priceController.text,
      count: countController.text,
      isActive: true,
      image: base64Encode(bytes.value),
    );
    final resultOrExeption = await _addProductRepository.addProduct(dto: dto);
    resultOrExeption.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) => {
        Get.back(result: right, closeOverlays: true, canPop: true),
        Get.showSnackbar(
          WidgetUtils.myCustomSnackBar(
              messageText: "${right.title} added",
              backgroundColor: Colors.greenAccent),
        ),
      },
    );
  }

  onAddButtonTapped() async {
    if (formKey.currentState!.validate()) {
      await addProduct();
    }
  }
}
