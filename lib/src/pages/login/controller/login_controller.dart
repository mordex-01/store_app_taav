import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_dto.dart';
import 'package:store_app_taav/src/shared/remember_me_repository.dart';
import 'package:store_app_taav/src/shared/repository_get_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  //
  @override
  void onInit() {
    getRememberMeUser();
    getStorgeData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    userNameController.clear();
    passwordController.clear();
    userNameController.dispose();
    passwordController.dispose();
  }

  Rx<bool> isLoginButtonLoading = false.obs;
  Rx<bool> isSignUpLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<bool> isObscure = false.obs;
  Rx<bool> isRememberMeCheck = false.obs;
  RxString userId = RxString("");
  RxString route = RxString("");
  Rx<bool> isSeller = false.obs;
  Rx<bool> isCustomer = false.obs;

  //
  Future<void> storgeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("rememberMe", isRememberMeCheck.value);
  }

//
  Future<void> getStorgeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRemember = prefs.getBool("rememberMe");
    bool? isSellerr = prefs.getBool("isSeller");
    bool? isCustomerr = prefs.getBool("isCustomer");
    String? userIdd = prefs.getString("userIdd");

    if (isRemember != null) {
      if (isSellerr != null) {
        if (isCustomerr != null) {
          if (isRemember) {
            isRememberMeCheck.value = isRemember;
            if (isSellerr) {
              Get.offAllNamed(RouteNames.sellerPageRoute, arguments: userIdd);
              isSeller.value = false;
            }
            if (isCustomerr) {
              Get.offAllNamed(RouteNames.customerPageRoute, arguments: userIdd);
              isCustomer.value = false;
            }
          }
        }
      }
    }
  }

  toggleObscure() => isObscure.value = !isObscure.value;
  toggleIsRememberMe() => isRememberMeCheck.value = !isRememberMeCheck.value;

  final RepositoryGetUsers _repositoryGetUsers = RepositoryGetUsers();
  Future<void> getRememberMeUser() async {
    final resultGetSellers =
        _repositoryGetUsers.getUsers(routeUrl: RepositoryUtils.getSellers);

    final resultGetCustomers =
        _repositoryGetUsers.getUsers(routeUrl: RepositoryUtils.getCustomers);

    resultGetSellers.fold(
      (left) => null,
      (right) => {
        for (int x = 0; x < right.length; x++)
          {
            if (right[x].isRememberMe == true)
              {
                Get.offAllNamed(RouteNames.sellerPageRoute,
                    arguments: right[x].id),
              }
          }
      },
    );
    resultGetCustomers.fold(
      (left) => null,
      (right) => {
        for (int x = 0; x < right.length; x++)
          {
            if (right[x].isRememberMe == true)
              {
                Get.offAllNamed(RouteNames.customerPageRoute,
                    arguments: right[x].id),
              }
          }
      },
    );
  }

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
                route.value = "/seller",
                userId.value = right[x].id,
                isSeller.value = true,
                if (formKey.currentState!.validate())
                  {
                    Get.offAllNamed(RouteNames.sellerPageRoute,
                        arguments: userId.value),
                  },
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
                  route.value = "/customer",
                  userId.value = right[x].id,
                  isCustomer.value = true,
                  if (formKey.currentState!.validate())
                    {
                      Get.offAllNamed(RouteNames.customerPageRoute,
                          arguments: userId.value),
                    },
                }
            }
        },
      );
      if (!isCustomer.value) {
        Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: "User Name Or Password are Invalid",
            backgroundColor: Colors.redAccent));
      }
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSeller", isSeller.value);
    prefs.setBool("isCustomer", isCustomer.value);
    prefs.setString("userIdd", userId.value);
    if (isRememberMeCheck.value == true) {
      final dto = RememberMeDto(isRememberMeCheck.value);
      final resultOrExeption = _rememberMeRepository.patchRememberMe(
          route: route.value, id: userId.value, dto: dto);
      resultOrExeption.fold(
          (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
              messageText: left, backgroundColor: Colors.redAccent)),
          (right) => null);
    }
    isRememberMeCheck.value = false;
  }

  onLoginTapped() async {
    isLoginButtonLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if (formKey.currentState!.validate()) {
      getUsers();
      storgeData();
      isLoginButtonLoading.value = false;
    }
    isLoginButtonLoading.value = false;
  }

  onSignUpTapped() async {
    isSignUpLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    Get.toNamed(RouteNames.loginPageRoute + RouteNames.signUpPageRoute);
    isSignUpLoading.value = false;
  }
}
