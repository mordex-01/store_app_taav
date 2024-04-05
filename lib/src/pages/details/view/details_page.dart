import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/pages/details/controller/details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(RouteNames.customerPageRoute);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          controller.image.value,
          const Divider(),
          Row(
            children: [
              const Text(
                "  Title : ",
                style: TextStyle(fontSize: 24),
              ),
              Obx(
                () => Text(
                  controller.productTitle.value,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                "  Description : ",
                style: TextStyle(fontSize: 24),
              ),
              Obx(
                () => Text(
                  controller.productDescription.value,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Text(
                "  Price : ",
                style: TextStyle(fontSize: 24),
              ),
              Obx(
                () => Text(
                  controller.productPrice.value,
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "  Colors : ",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: Obx(
                  () => ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      selectedColors(color: controller.color1.value),
                      selectedColors(color: controller.color2.value),
                      selectedColors(color: controller.color3.value),
                      selectedColors(color: controller.color4.value),
                      selectedColors(color: controller.color5.value)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }

  Widget selectedColors({
    required Color? color,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          width: 35,
          height: 35,
        ),
      );
}
