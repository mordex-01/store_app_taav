import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/src/pages/signup/model/signup_model_dto.dart';
import 'package:store_app_taav/src/pages/signup/repository/signup_repository.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RxList<String> radioOptions = <String>['Seller', 'Customer'].obs;
  RxString radioCurrentOption = RxString('Seller');
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SignUpRepository _repository = SignUpRepository();
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

  onSignUpTapped() {
    if (formKey.currentState!.validate()) {
      signUp();
      return Get.back();
    }
  }
}
