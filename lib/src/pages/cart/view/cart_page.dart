import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_picker/number_picker.dart';
import 'package:store_app_taav/src/pages/cart/controller/cart_controller.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.onBackButtonPressed();
                // Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() => controller.cartsList.isEmpty
                  ? const Center(child: Text("No Carts Exist"))
                  : ListView.builder(
                      itemCount: controller.cartsList.length,
                      itemBuilder: (context, index) => _cartBox(
                        context: context,
                        productTitle: controller.cartsList[index].title,
                        price: int.parse(controller.cartsList[index].price),
                        cartItemCount:
                            int.parse(controller.cartsList[index].cartCount!),
                        onRightButtonPressed: () =>
                            controller.onRightNumberPickerPressed(index: index),
                        onLeftButtonPressed: () =>
                            controller.onLeftNumberPickerPressed(index: index),
                        onDeleteButtonPressed: () =>
                            controller.onDeleteButtonPressed(index: index),
                      ),
                    )),
            ),
            const Divider(),
            Row(
              children: [
                const Text(
                  "  Total Price : ",
                  style: TextStyle(fontSize: 24),
                ),
                Obx(() => Text(controller.totalPrice.value.toString()))
              ],
            ),
            const Expanded(child: SizedBox()),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () => controller.onPaymentButtonPressed(),
                    child: _paymentButton(context: context, lable: "Payment")))
          ],
        )
        // Obx(
        //   () => ListView.builder(
        //       itemCount: controller.cartList.length,
        //       itemBuilder: (context, index) => _cartBox(
        //             onDeleteButtonPressed: () => controller.onDeleteTapped(
        //                 id: controller.cartList[index].id),
        //             context: context,
        //             productTitle: controller.cartList[index].productTitle,
        //             cartItemCount: int.parse(controller.cartList[index].count),
        //             price: int.parse(controller.cartList[index].price),
        //             onLeftButtonPressed: () {
        //               controller.onLeftNumberPickerTapped(
        //                   index: index, id: controller.cartList[index].id);
        //             },
        //             onRightButtonPressed: () {
        //               controller.onRightNumberPickerTapped(
        //                   index: index, id: controller.cartList[index].id);
        //             },
        //           )),
        // ),
        );
  }

  Widget _paymentButton(
          {required BuildContext context, required String lable}) =>
      Container(
        margin: const EdgeInsets.all(12),
        width: MediaQuery.sizeOf(context).width / 1.5,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.blue[800], borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            lable,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      );
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
