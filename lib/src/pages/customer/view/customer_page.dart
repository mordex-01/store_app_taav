import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/customer/controller/customer_controller.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';

class CustomerPage extends GetView<CustomerController> {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Badge(
                label: Obx(
                  () => Text(controller.cartCount.value != 0
                      ? controller.cartCount.value.toString()
                      : "0"),
                ),
                child: IconButton(
                    onPressed: () {
                      controller.onCartIconTapped();
                    },
                    icon: const Icon(Icons.shopping_cart))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.language),
                      Text("  Change Language"),
                    ],
                  ),
                  onTap: () {},
                ),
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.logout),
                      Text("  LogOut"),
                    ],
                  ),
                  onTap: () {
                    controller.onBackTapped();
                  },
                )
              ],
            ),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.productsList.length,
          itemBuilder: (context, index) => productBox(
            itemCount: int.parse(controller.productsList[index].count),
            onTap: () => controller.goToDetailsPage(index: index),
            context: context,
            product: controller.productsList[index],
            image: controller.productsList[index].image != null &&
                    controller.productsList[index].image!.isNotEmpty
                ? Image.memory(
                    Uint8List.fromList(
                        base64Decode(controller.productsList[index].image!)),
                    fit: BoxFit.cover,
                  )
                : Image.asset("assets/no-image-icon.png"),
            tagItemCount: controller.productsList[index].tag.length,
          ),
        ),
      ),
    );
  }

  Widget productBox({
    required BuildContext context,
    required Widget? image,
    required ProductViewModel product,
    required int tagItemCount,
    required int itemCount,
    required void Function()? onTap,
  }) =>
      InkWell(
        hoverColor: Colors.white10,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(40),
          height: 370,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 2, color: Colors.blue),
              bottom: BorderSide(width: 2, color: Colors.blue),
              left: BorderSide(width: 2, color: Colors.blue),
              right: BorderSide(width: 2, color: Colors.blue),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 150,
                child: image,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8),
                child: Text(product.description),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    selectedColors(color: Color(int.parse(product.color[0]))),
                    selectedColors(color: Color(int.parse(product.color[1]))),
                    selectedColors(color: Color(int.parse(product.color[2]))),
                    selectedColors(color: Color(int.parse(product.color[3]))),
                    selectedColors(color: Color(int.parse(product.color[4]))),
                    const Expanded(child: SizedBox()),
                    Column(
                      children: [
                        Text("Price ${product.price}"),
                        Text("Count $itemCount")
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.blue,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tagItemCount,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Chip(label: Text(product.tag[index])),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  Widget selectedColors({
    required Color? color,
  }) =>
      Container(
        margin: const EdgeInsets.only(top: 20.0, right: 20),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        width: 25,
        height: 25,
      );
}
