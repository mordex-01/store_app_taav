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
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Obx(() {
                return controller.bytes.value.isNotEmpty
                    ? Container(
                        width: MediaQuery.sizeOf(context).width - 50,
                        height: MediaQuery.sizeOf(context).height / 8,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blue[900]!, width: 2)),
                        child: Image.memory(
                          controller.bytes.value,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Text("Please Select an Image First");
              }),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: _textFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "title cant be null";
                        }
                        return null;
                      },
                      controller: controller.titleController,
                      hintText: "Title",
                      isOutline: false,
                      maxLines: 1)),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: _textFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "description cant be null";
                        }
                        return null;
                      },
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _pickImageButton(
                    context: context,
                    onTap: () {
                      controller.getImage();
                    }),
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
          String? Function(String?)? validator,
          TextEditingController? controller}) =>
      TextFormField(
        validator: validator,
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
  Widget _pickImageButton(
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
              "PickImage",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      );
}
