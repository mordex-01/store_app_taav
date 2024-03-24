import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                              "You Can Select Image For Your Product ==>"),
                          IconButton(
                            onPressed: () {
                              controller.getImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 40,
                            ),
                          )
                        ],
                      );
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
              const Divider(),
              const Text("Add Your Colors To Your Product"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      selectedColors(
                          color: controller.color1.value,
                          isEnabled: controller.isColorSelected1.value,
                          onRemovePressed: () {
                            controller.isColorSelected1.value =
                                !controller.isColorSelected1.value;
                            controller.color1.value = Colors.white;
                          }),
                      selectedColors(
                          color: controller.color2.value,
                          isEnabled: controller.isColorSelected2.value,
                          onRemovePressed: () {
                            controller.isColorSelected2.value =
                                !controller.isColorSelected2.value;
                            controller.color2.value = Colors.white;
                          }),
                      selectedColors(
                          color: controller.color3.value,
                          isEnabled: controller.isColorSelected3.value,
                          onRemovePressed: () {
                            controller.isColorSelected3.value =
                                !controller.isColorSelected3.value;
                            controller.color3.value = Colors.white;
                          }),
                      selectedColors(
                          color: controller.color4.value,
                          isEnabled: controller.isColorSelected4.value,
                          onRemovePressed: () {
                            controller.isColorSelected4.value =
                                !controller.isColorSelected4.value;
                            controller.color4.value = Colors.white;
                          }),
                      selectedColors(
                          color: controller.color5.value,
                          isEnabled: controller.isColorSelected5.value,
                          onRemovePressed: () {
                            controller.isColorSelected5.value =
                                !controller.isColorSelected5.value;
                            controller.color5.value = Colors.white;
                          }),
                      IconButton(
                        onPressed: () {
                          controller.pickColor(
                            context: context,
                            buildColorPicker: _buildColorPicker(
                              onColorChangeEnd: (value) {
                                if (!controller.isColorSelected5.value &&
                                    controller.isColorSelected1.value &&
                                    controller.isColorSelected2.value &&
                                    controller.isColorSelected3.value &&
                                    controller.isColorSelected4.value) {
                                  controller.color5.value = value;
                                }
                                if (!controller.isColorSelected4.value &&
                                    controller.isColorSelected1.value &&
                                    controller.isColorSelected2.value &&
                                    controller.isColorSelected3.value) {
                                  controller.color4.value = value;
                                }
                                if (!controller.isColorSelected3.value &&
                                    controller.isColorSelected1.value &&
                                    controller.isColorSelected2.value) {
                                  controller.color3.value = value;
                                }
                                if (!controller.isColorSelected2.value &&
                                    controller.isColorSelected1.value) {
                                  controller.color2.value = value;
                                }
                                if (!controller.isColorSelected1.value) {
                                  controller.color1.value = value;
                                }
                              },
                            ),
                            onSelectPressed: () {
                              if (!controller.isColorSelected5.value &&
                                  controller.isColorSelected1.value &&
                                  controller.isColorSelected2.value &&
                                  controller.isColorSelected3.value &&
                                  controller.isColorSelected4.value) {
                                controller.isColorSelected5.value = true;
                              }
                              if (!controller.isColorSelected4.value &&
                                  controller.isColorSelected1.value &&
                                  controller.isColorSelected2.value &&
                                  controller.isColorSelected3.value) {
                                controller.isColorSelected4.value = true;
                              }
                              if (!controller.isColorSelected3.value &&
                                  controller.isColorSelected1.value &&
                                  controller.isColorSelected2.value) {
                                controller.isColorSelected3.value = true;
                              }
                              if (!controller.isColorSelected2.value &&
                                  controller.isColorSelected1.value) {
                                controller.isColorSelected2.value = true;
                              }
                              if (!controller.isColorSelected1.value) {
                                controller.isColorSelected1.value = true;
                              }
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.add_box_outlined,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget selectedColors(
          {required Color? color,
          required bool isEnabled,
          required void Function()? onRemovePressed}) =>
      Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0, right: 20),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            width: 40,
            height: 40,
          ),
          isEnabled
              ? Positioned(
                  top: 0,
                  right: 0.5,
                  child: IconButton(
                    onPressed: onRemovePressed,
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 15,
                    ),
                  ),
                )
              : Positioned(child: Container())
        ],
      );

  Widget _buildColorPicker({required void Function(Color)? onColorChangeEnd}) =>
      ColorPicker(
        enableOpacity: false,
        enableShadesSelection: false,
        enableTonalPalette: false,
        enableTooltips: false,
        onColorChanged: (value) {},
        onColorChangeEnd: onColorChangeEnd,
      );
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
}
