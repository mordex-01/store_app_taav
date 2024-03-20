import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/utils/widget_utils.dart';
import 'package:store_app_taav/src/pages/login/model/remember_me_dto.dart';
import 'package:store_app_taav/src/shared/remember_me_repository.dart';

class SellerController extends GetxController {
  @override
  void onInit() {
    if (args != null) {
      saveArgs();
    }
    super.onInit();
  }

  RxBool isSwiched = RxBool(false);
  final RememberMeRepository _rememberMeRepository = RememberMeRepository();
  final dto = RememberMeDto(false);
  final args = Get.arguments;

  Future<void> saveArgs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("myUserId", args);
  }

  // Future<void> deleteArgs() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.remove("myUserId");
  // }

  Future<void> onBackTapped() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("rememberMe", false);
    String userId = pref.getString("myUserId") as String;
    final resultOrExeption = await _rememberMeRepository.patchRememberMe(
        route: "/seller", id: userId, dto: dto);
    resultOrExeption.fold(
        (left) => Get.showSnackbar(WidgetUtils.myCustomSnackBar(
            messageText: left, backgroundColor: Colors.redAccent)),
        (right) => null);
    bool? isSeller = pref.getBool("isSeller");
    bool? isCustomer = pref.getBool("isCustomer");
    if (isSeller != null) {
      if (isSeller) {
        pref.setBool("isSeller", false);
      }
    }
    if (isCustomer != null) {
      if (isCustomer) {
        pref.setBool("isCustomer", false);
      }
    }
    Get.offAllNamed(RouteNames.loginPageRoute);
  }
}
