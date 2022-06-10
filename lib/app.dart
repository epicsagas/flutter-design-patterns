import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'navigation/router.dart';
import 'themes.dart';

class App extends StatelessWidget {
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Flutter Design Patterns',
      theme: lightTheme,
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
