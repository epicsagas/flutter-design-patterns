import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'markdown_store.dart';

class LanguageStore extends GetxController {
  final sysLanguageCode = ui.window.locale.languageCode;
  final List<String> languageNames = [];
  late final languageList;

  RxString sysLanguageName = "English".obs;
  RxMap<String, String> currentLanguage = {
    "code": "en",
    "name": "English",
  }.obs;

  @override
  Future<void> onInit() async {
    await setLanguageList();
    final _currentLanguage = findLanguageByCode(sysLanguageCode);
    changeLanguage(code: sysLanguageCode, name: _currentLanguage['name'].toString());

    super.onInit();
  }

  // set initial language list
  Future<void> setLanguageList() async {
    final String languagesJson = await rootBundle.loadString("assets/data/languages.json");
    languageList = await json.decode(languagesJson);
    languageList.forEach((item) => languageNames.add(item['name'].toString()));

    update();
  }

  // change language
  void changeLanguage({String code = '', String name = ''}) async {
    var _language;
    if (name.isNotEmpty) {
      _language = findLanguageByName(name);
    } else if (code.isNotEmpty) {
      _language = findLanguageByCode(code);
    }

    if (_language != null) {
      currentLanguage.value = {
        "code": _language['code'].toString(),
        "name": _language['name'].toString()
      };
    }
  }

  // find language item by name
  dynamic findLanguageByName(String name) {
    return languageList.firstWhere((language) => language['name'] == name, orElse: () { return null; });
  }

  // find language item by code
  dynamic findLanguageByCode(String code) {
    return languageList.firstWhere((language) => language['code'] == code, orElse: () { return null; });
  }
}