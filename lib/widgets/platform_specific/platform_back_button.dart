import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../navigation/router.dart';
import '../../state_controllers/markdown_controller.dart';

class PlatformBackButton extends StatelessWidget {
  final Color color;

  const PlatformBackButton({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final MarkdownController mdController = Get.put(MarkdownController());
    final icon = kIsWeb || Platform.isAndroid
        ? Icons.arrow_back
        : Icons.arrow_back_ios_new;

    return IconButton(
      icon: Icon(icon),
      color: color,
      splashRadius: 20.0,
      onPressed: () async {
        await mdController.reset();

        context.router.canPopSelfOrChildren
            ? context.popRoute()
            : context.navigateTo(const MainMenuRoute());
      },
    );
  }
}
