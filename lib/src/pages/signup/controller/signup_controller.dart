import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/utils/repository_utils.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/signup/model/signup_model_dto.dart';
import 'package:store_app_taav/src/pages/signup/repository/signup_repository.dart';
import 'package:store_app_taav/src/shared/repository_getusers.dart';

class SignUpController extends GetxController {
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  final formKey = GlobalKey<FormState>();
  final RxList<String> radioOptions = <String>['Seller', 'Customer'].obs;
  RxString radioCurrentOption = RxString('Seller');
  late bool isUserNameWrong = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final SignUpRepository _repository = SignUpRepository();
  final RepositoryGetUsers _getUsersRepository = RepositoryGetUsers();
  Future<void> signUp() async {
    final dto = SignUpModelDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: userNameController.text,
        password: passwordController.text);
    final resultOrExeption = await _repository.signUpCustomer(
        dto: dto, routeUrl: "/${radioCurrentOption.value.toLowerCase()}");
    resultOrExeption.fold(
      (left) => Get.showSnackbar(GetSnackBar(
        message: left,
        duration: const Duration(seconds: 2),
      )),
      (right) => Get.showSnackbar(
        GetSnackBar(
          backgroundColor: Colors.lightGreenAccent,
          margin: const EdgeInsets.all(16),
          borderRadius: 25,
          messageText: Text(
            "User Name -> ${right.userName} --Created--",
            style: const TextStyle(color: Colors.black),
          ),
          duration: const Duration(seconds: 2),
        ),
      ),
    );
  }

  Future<void> getUsers() async {
    final resultGetSellers = await _getUsersRepository.getUsers(
        routeUrl: RepositoryUtils.getSellers);

    final resultGetCustomers = await _getUsersRepository.getUsers(
        routeUrl: RepositoryUtils.getCustomers);
    resultGetSellers.fold(
      (left) => Get.showSnackbar(
        WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent),
      ),
      (right) => {
        for (int x = 0; x < right.length; x++)
          {
            if (userNameController.text == right.elementAt(x).userName)
              {
                isUserNameWrong = true,
              }
          }
      },
    );
    resultGetCustomers.fold(
      (left) => Get.showSnackbar(
        WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent),
      ),
      (right) => {
        for (int x = 0; x < right.length; x++)
          {
            if (userNameController.text == right.elementAt(x).userName)
              {
                isUserNameWrong = true,
              }
          }
      },
    );
  }
  // Future<void> getUsers() async {
  //   final resultOrExeption = await _getUsersRepository.getUsers(
  //       routeUrl: "/${radioCurrentOption.value.toLowerCase()}");
  //   resultOrExeption.fold(
  //     (left) => Get.showSnackbar(
  //       WidgetUtils.myCustomSnackBar(
  //           messageText: left, backgroundColor: Colors.redAccent),
  //     ),
  //     (right) => {
  //       for (int x = 0; x < right.length; x++)
  //         {
  //           if (userNameController.text == right.elementAt(x).userName)
  //             {
  //               isUserNameWrong = true,
  //             }
  //         }
  //     },
  //   );
  // }

  onSignUpTapped() async {
    await getUsers();
    if (isUserNameWrong == true) {
      Get.showSnackbar(
        WidgetUtils.myCustomSnackBar(
            messageText: "This User Name Already Created",
            backgroundColor: Colors.redAccent),
      );
      isUserNameWrong = false;
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.showSnackbar(
        WidgetUtils.myCustomSnackBar(
            messageText: "Password and Confirm Password Are Not Same",
            backgroundColor: Colors.redAccent),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      signUp();
      firstNameController.clear();
      lastNameController.clear();
      userNameController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      return Get.back();
    }
  }
}
