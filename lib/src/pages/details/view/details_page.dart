import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/pages/details/controller/details_controller.dart';
import 'package:number_picker/number_picker.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => controller.image.value),
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
            const Divider(),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "  Tags :",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Wrap(
                    spacing: 5,
                    children: List.generate(
                      controller.productTags.length,
                      (index) => Chip(
                        label: Text(
                          controller.productTags[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                addToCardButton(context: context),
                Obx(
                  () => CustomNumberPicker(
                      onLeftButtonPressed: () {
                        controller.onNumberPickerLeftButtonTapped();
                      },
                      onRightButtonPressed: () {
                        controller.onNumberPickerRightButtonTapped();
                      },
                      textData: controller.productItemCount.value),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget addToCardButton({required BuildContext context}) => InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.sizeOf(context).width / 1.5,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.blue[900], borderRadius: BorderRadius.circular(20)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add To Card",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              )
            ],
          ),
        ),
      );

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
