import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<bool> isObscure = false.obs;
  Rx<bool> isRememberMeCheck = false.obs;
  toggleObscure() => isObscure.value = !isObscure.value;
  toggleIsRememberMe() => isRememberMeCheck.value = !isRememberMeCheck.value;
}
