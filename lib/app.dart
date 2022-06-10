import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation/router.dart';
import 'state_controllers/language_controller.dart';
import 'themes.dart';

class App extends StatelessWidget {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());
    languageController.init();

    return GetMaterialApp.router(
      title: 'Flutter Design Patterns',
      theme: lightTheme,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
