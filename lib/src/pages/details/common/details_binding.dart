import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/details/controller/details_controller.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController());
  }
}
