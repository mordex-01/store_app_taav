import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
