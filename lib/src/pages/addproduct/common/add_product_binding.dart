import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/addproduct/controller/add_product_controller.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}
