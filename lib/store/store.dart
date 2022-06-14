import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'language_store.dart';
import 'markdown_store.dart';

class Store extends GetxController with WidgetsBindingObserver {
  final LanguageStore language = Get.put(LanguageStore());
  final MarkdownStore md = Get.put(MarkdownStore());

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    ever(language.currentLanguage.obs, (language) => log(language.toString()));

    language.obs.listen((p0) {
      log(p0.toString());
    });
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }
}