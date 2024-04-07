import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/number_picker/lib/number_picker.dart';
import 'package:store_app_taav/src/pages/cart/controller/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: controller.cartList.length,
            itemBuilder: (context, index) => _cartBox(
                  onDeleteButtonPressed: () => controller.onDeleteTapped(
                      id: controller.cartList[index].id),
                  context: context,
                  productTitle: controller.cartList[index].productTitle,
                  cartItemCount: int.parse(controller.cartList[index].count),
                  price: int.parse(controller.cartList[index].price),
                  onLeftButtonPressed: () {
                    controller.onLeftNumberPickerTapped(
                        index: index, id: controller.cartList[index].id);
                  },
                  onRightButtonPressed: () {
                    controller.onRightNumberPickerTapped(
                        index: index, id: controller.cartList[index].id);
                  },
                )),
      ),
    );
  }

  Widget _cartBox({
    required BuildContext context,
    required String productTitle,
    required int price,
    required int cartItemCount,
    required void Function()? onRightButtonPressed,
    required void Function()? onLeftButtonPressed,
    required void Function()? onDeleteButtonPressed,
  }) =>
      Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.sizeOf(context).width,
          height: 150,
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(productTitle),
                  IconButton(
                    onPressed: onDeleteButtonPressed,
                    icon: const Icon(Icons.delete),
                  )
                ],
              ),
              Text(price.toString()),
              CustomNumberPicker(
                  onLeftButtonPressed: onLeftButtonPressed,
                  onRightButtonPressed: onRightButtonPressed,
                  textData: cartItemCount),
            ],
          ),
        ),
      );
}
