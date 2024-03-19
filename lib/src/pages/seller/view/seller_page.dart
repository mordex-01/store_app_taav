import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/seller/controller/seller_controller.dart';

class SellerPage extends GetView<SellerController> {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            final SharedPreferences pref =
                await SharedPreferences.getInstance();
            pref.setBool("rememberMe", false);
            bool? isSeller = pref.getBool("isSeller");
            bool? isCustomer = pref.getBool("isCustomer");
            if (isSeller != null) {
              if (isSeller) {
                pref.setBool("isSeller", false);
              }
            }
            if (isCustomer != null) {
              if (isCustomer) {
                pref.setBool("isCustomer", false);
              }
            }
            Get.offAllNamed(RouteNames.loginPageRoute);
          },
          icon: WidgetUtils.arrowBackButton,
        ),
      ),
    );
  }
}
