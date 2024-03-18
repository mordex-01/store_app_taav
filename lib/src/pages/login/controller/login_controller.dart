import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  Rx<bool> isObscure = false.obs;
  Rx<bool> isRememberMeCheck = false.obs;
  toggleObscure() => isObscure.value = !isObscure.value;
  toggleIsRememberMe() => isRememberMeCheck.value = !isRememberMeCheck.value;

  onLoginTapped() {
    if (formKey.currentState!.validate()) {}
  }

  onSignUpTapped() {
    Get.toNamed(RouteNames.loginPageRoute + RouteNames.signUpPageRoute);
  }
}
