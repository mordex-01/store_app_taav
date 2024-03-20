import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/seller/controller/seller_controller.dart';

class SellerPage extends GetView<SellerController> {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap: () {},
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
        leading: IconButton(
          onPressed: () async {
            await controller.onBackTapped();
          },
          icon: WidgetUtils.arrowBackButton,
        ),
      ),
      body: Center(
        child: _productBox(
          onTap: () {},
          title: "thats title",
          description: "thats description",
          price: "500",
        ),
      ),
    );
  }

  Widget _productBox(
          {required String title,
          required String description,
          required String price,
          required void Function()? onTap}) =>
      Container(
        width: 313,
        height: 415,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2, color: Colors.blue),
            left: BorderSide(width: 2, color: Colors.blue),
            right: BorderSide(width: 2, color: Colors.blue),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 313,
              height: 150,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 8, left: 8),
              child: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 22,
                    height: 22,
                    color: Colors.red,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 22,
                    height: 22,
                    color: Colors.blue,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 22,
                    height: 22,
                    color: Colors.green,
                  ),
                  const Expanded(child: SizedBox()),
                  Text("Price $price"),
                ],
              ),
            ),
            const Divider(
              color: Colors.blue,
            ),
            const Expanded(child: SizedBox()),
            const Divider(
              color: Colors.blue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Switch(
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.red,
                          value: controller.isSwiched.value,
                          onChanged: (value) {
                            controller.isSwiched.value = value;
                          },
                        ),
                        controller.isSwiched.value
                            ? const Text("active")
                            : const Text("disable")
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 84,
                    height: 32,
                    color: const Color.fromRGBO(0, 80, 219, 1),
                    child: const Center(
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
