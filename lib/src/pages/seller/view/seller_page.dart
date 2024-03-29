import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/seller/controller/seller_controller.dart';
import 'package:store_app_taav/src/pages/seller/view/my_product_box.dart';

class SellerPage extends GetView<SellerController> {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap: () {
          controller.onAddButtonTapped();
        },
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          width: 65,
          height: 65,
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PopupMenuButton(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                //fill that later
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "item1",
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      Text("  Change Language"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: "item2",
                  child: const Row(
                    children: [
                      Icon(Icons.filter_list_rounded),
                      Text("  Filter"),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Filter Products"),
                        content: Column(
                          children: [
                            const Divider(),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                            ),
                            const Text("Set Price Range"),
                            Obx(
                              () => RangeSlider(
                                values: controller.selectedRange.value,
                                onChanged: (value) {
                                  controller.selectedRange.value = value;
                                },
                                min: controller.sliderMinValue.value,
                                max: controller.sliderMaxValue.value,
                                divisions: 100,
                                // labels: RangeLabels(
                                //     "${controller.selectedRange.value.start}",
                                //     "${controller.selectedRange.value.end}"),
                              ),
                            ),
                            Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Min ${controller.selectedRange.value.start}"),
                                  Text(
                                      "Max ${controller.selectedRange.value.end}")
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                PopupMenuItem(
                  value: "item3",
                  child: const Row(
                    children: [
                      Icon(Icons.logout),
                      Text("  LogOut"),
                    ],
                  ),
                  onTap: () {
                    controller.onBackTapped();
                  },
                ),
              ],
            ),
          ),
        ],
        title: TextField(
          onChanged: (value) {
            controller.onSearchTextChanged(value);
          },
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.getProducts(),
          child: ListView.builder(
            itemCount: controller.productsList.length,
            itemBuilder: (context, index) => Obx(
              () {
                return _productBox(index: index);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _productBox({required int index}) => MyProductBox(
        tagItemCount: controller.productsList[index].tag.length,
        index: index,
        id: controller.productsList[index].id,
        product: controller.productsList[index],
        image: controller.productsList[index].image != null &&
                controller.productsList[index].image!.isNotEmpty
            ? Image.memory(
                Uint8List.fromList(
                    base64Decode(controller.productsList[index].image!)),
                fit: BoxFit.cover,
              )
            : Image.asset("assets/no-image-icon.png"),
        onEditTap: () {},
      );

//i commend what i dont use
  // Widget _productBox(
  //         {required BuildContext context,
  //         required String title,
  //         required String description,
  //         required String price,
  //         required Widget boxSwichButton,
  //         required void Function()? onEditTap}) =>
  //     Container(
  //       margin: const EdgeInsets.all(40),
  //       height: 415,
  //       decoration: const BoxDecoration(
  //         border: Border(
  //           bottom: BorderSide(width: 2, color: Colors.blue),
  //           left: BorderSide(width: 2, color: Colors.blue),
  //           right: BorderSide(width: 2, color: Colors.blue),
  //         ),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             width: MediaQuery.sizeOf(context).width,
  //             height: 150,
  //             color: Colors.black,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(
  //               title,
  //               style: const TextStyle(fontSize: 20),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8),
  //             child: Text(description),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   margin: const EdgeInsets.all(8),
  //                   width: 22,
  //                   height: 22,
  //                   color: Colors.red,
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.all(8),
  //                   width: 22,
  //                   height: 22,
  //                   color: Colors.blue,
  //                 ),
  //                 Container(
  //                   margin: const EdgeInsets.all(8),
  //                   width: 22,
  //                   height: 22,
  //                   color: Colors.green,
  //                 ),
  //                 const Expanded(child: SizedBox()),
  //                 Text("Price $price"),
  //               ],
  //             ),
  //           ),
  //           const Divider(
  //             color: Colors.blue,
  //           ),
  //           const Expanded(child: SizedBox()),
  //           const Divider(
  //             color: Colors.blue,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               // controller.isLoading.value
  //               //     ? const CircularProgressIndicator()
  //               //     :
  //               boxSwichButton,
  //               InkWell(
  //                 onTap: onEditTap,
  //                 child: Container(
  //                   margin: const EdgeInsets.all(8),
  //                   width: 84,
  //                   height: 32,
  //                   color: const Color.fromRGBO(0, 80, 219, 1),
  //                   child: const Center(
  //                     child: Text(
  //                       "Edit",
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  // Widget _isSwichButton(
  //         {required bool value, required void Function(bool)? onChanged}) =>
  //     Padding(
  //       padding: const EdgeInsets.all(8),
  //       child: Switch(
  //         activeColor: Colors.blue,
  //         inactiveThumbColor: Colors.red,
  //         value: value,
  //         onChanged: onChanged,
  //       ),
  //     );
}
