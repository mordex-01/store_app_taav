import 'package:get/get.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/pages/login/common/login_binding.dart';
import 'package:store_app_taav/src/pages/login/view/login_page.dart';

class RoutePages {
  static List<GetPage> getPages = [
    GetPage(
      name: RouteNames.loginPageRoute,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    )
  ];
}
