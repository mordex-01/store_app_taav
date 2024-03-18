import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/shared/repository_getusers.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<bool> isObscure = false.obs;
  Rx<bool> isRememberMeCheck = false.obs;
  Rx<bool> isSeller = false.obs;
  Rx<bool> isCustomer = false.obs;
  toggleObscure() => isObscure.value = !isObscure.value;
  toggleIsRememberMe() => isRememberMeCheck.value = !isRememberMeCheck.value;
  final RepositoryGetUsers _repositoryGetUsers = RepositoryGetUsers();
  Future<void> getUsers() async {
    final resultGetSellers = await _repositoryGetUsers.getUsers(
        routeUrl: RepositoryUtils.getSellers);

    final resultGetCustomers = await _repositoryGetUsers.getUsers(
        routeUrl: RepositoryUtils.getCustomers);

    resultGetSellers.fold(
      (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
          messageText: left, backgroundColor: Colors.redAccent)),
      (right) => {
        for (int x = 0; x < right.length; x++)
          {
            if (right[x].userName == userNameController.text &&
                right[x].password == passwordController.text)
              {
                isSeller.value = true,
                if (formKey.currentState!.validate())
                  {Get.offAllNamed(RouteNames.sellerPageRoute)},
              }
          }
      },
    );
    if (!isSeller.value) {
      resultGetCustomers.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => {
          for (int x = 0; x < right.length; x++)
            {
              if (right[x].userName == userNameController.text &&
                  right[x].password == passwordController.text)
                {
                  isCustomer.value = true,
                  if (formKey.currentState!.validate())
                    {Get.offAllNamed(RouteNames.customerPageRoute)},
                }
            }
        },
      );
      if (!isCustomer.value) {
        Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: "User Name Or Password are Invalid",
            backgroundColor: Colors.redAccent));
      }
      isCustomer.value = false;
      isSeller.value = false;
    }
  }

  onLoginTapped() {
    if (formKey.currentState!.validate()) {
      getUsers();
      // if (isSeller.value == true) {
      //   Get.offAllNamed(RouteNames.sellerPageRoute);
      //   isSeller.value = false;
      // }
      // if (isCustomer.value == true) {
      //   Get.offAllNamed(RouteNames.customerPageRoute);
      //   isCustomer.value = false;
      // }
      // if (!isSeller.value && !isCustomer.value) {}
    }
  }

  onSignUpTapped() {
    Get.toNamed(RouteNames.loginPageRoute + RouteNames.signUpPageRoute);
  }
}
