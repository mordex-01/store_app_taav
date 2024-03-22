import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/seller/controller/seller_controller.dart';
import 'package:store_app_taav/src/pages/seller/model/product_view_model.dart';

class MyProductBox extends GetView<SellerController> {
  const MyProductBox(
      {super.key,
      this.image,
      required this.product,
      required this.onEditTap,
      required this.id,
      required this.index});
  final void Function()? onEditTap;
  final ProductViewModel product;
  final String id;
  final Widget? image;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
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
            width: MediaQuery.sizeOf(context).width,
            height: 150,
            color: Colors.black,
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
                Text("Price ${product.price}"),
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Obx(
                  () {
                    return controller.isPageLoading.value
                        ? const CircularProgressIndicator()
                        : Switch(
                            activeColor: Colors.blue,
                            inactiveThumbColor: Colors.red,
                            //
                            value: product.isActive,
                            //
                            onChanged: (value) {
                              controller.toggleIsActive(id, index);
                            },
                          );
                  },
                ),
              ),
              InkWell(
                onTap: onEditTap,
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
}

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
