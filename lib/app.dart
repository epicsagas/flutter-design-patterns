import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation/router.dart';
import 'store/store.dart';
import 'themes.dart';

class App extends StatelessWidget {
  final router = AppRouter();
  final Store store = Get.put(Store());

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
