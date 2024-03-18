import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/customer/controller/customer_controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomerController());
  }
}
