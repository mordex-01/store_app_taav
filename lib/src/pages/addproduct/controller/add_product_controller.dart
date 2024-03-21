import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';

class AddProductController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  onAddButtonTapped() {
    Get.offAndToNamed(RouteNames.sellerPageRoute, arguments: <String, String>{
      "title": titleController.text,
      "description": descriptionController.text,
      "price": priceController.text
    });
  }
}
