import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/signup/controller/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
