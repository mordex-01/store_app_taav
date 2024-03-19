import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/customer/controller/customer_controller.dart';

class CustomerPage extends GetView<CustomerController> {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await controller.onBackTapped();
          },
          icon: WidgetUtils.arrowBackButton,
        ),
      ),
    );
  }
}