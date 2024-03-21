import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/addproduct/controller/add_product_controller.dart';

class AddProductPage extends GetView<AddProductController> {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: _textFormField(
                      controller: controller.titleController,
                      hintText: "Title",
                      isOutline: false,
                      maxLines: 1)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: _textFormField(
                      controller: controller.descriptionController,
                      hintText: "Description",
                      isOutline: true,
                      maxLines: 3)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: _textFormField(
                      controller: controller.priceController,
                      hintText: "Price",
                      isOutline: false,
                      maxLines: 1)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _textFormField(
                    hintText: "count", isOutline: false, maxLines: 1),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8),
                child: _addButton(
                  context: context,
                  onTap: () {
                    controller.onAddButtonTapped();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormField(
          {required String hintText,
          required bool isOutline,
          required int maxLines,
          TextEditingController? controller}) =>
      TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 20),
          enabledBorder: isOutline
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.blue[700]!, width: 2))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
                ),
        ),
      );
  Widget _addButton(
          {required BuildContext context, required void Function()? onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Center(
            child: Text(
              "Add",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      );
}
