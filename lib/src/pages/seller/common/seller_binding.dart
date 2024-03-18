import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/seller/controller/seller_controller.dart';

class SellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SellerController());
  }
}
