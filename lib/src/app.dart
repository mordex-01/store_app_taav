import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app_taav/generated/locales.g.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_names.dart';
import 'package:store_app_taav/src/infrastructure/routes/route_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale("en", "US"),
      translations: AppTranslation(),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.loginPageRoute,
      getPages: RoutePages.getPages,
    );
  }
}
