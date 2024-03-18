import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/pages/customer/common/customer_binding.dart';
import 'package:store_app_taav/src/pages/customer/view/customer_page.dart';
import 'package:store_app_taav/src/pages/login/common/login_binding.dart';
import 'package:store_app_taav/src/pages/login/view/login_page.dart';
import 'package:store_app_taav/src/pages/seller/common/seller_binding.dart';
import 'package:store_app_taav/src/pages/seller/view/seller_page.dart';
import 'package:store_app_taav/src/pages/signup/common/signup_binding.dart';
import 'package:store_app_taav/src/pages/signup/view/signup_page.dart';

class RoutePages {
  static List<GetPage> getPages = [
    GetPage(
      name: RouteNames.loginPageRoute,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      children: [
        GetPage(
          name: RouteNames.signUpPageRoute,
          page: () => const SignUpPage(),
          binding: SignUpBinding(),
        )
      ],
    ),
    GetPage(
      name: RouteNames.customerPageRoute,
      page: () => const CustomerPage(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: RouteNames.sellerPageRoute,
      page: () => const SellerPage(),
      binding: SellerBinding(),
    ),
  ];
}
