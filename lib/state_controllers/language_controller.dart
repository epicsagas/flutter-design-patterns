import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'markdown_controller.dart';

class LanguageController extends GetxController {
  RxMap<String, String> currentLanguage = {
    "code": "en",
    "name": "English"
  }.obs;
  var languageList;
  List<String> languageNames = [];

  init() {
    setLanguageList();
  }

  setLanguageList() async {
    final String languagesJson = await rootBundle.loadString("assets/data/languages.json");
    languageList = await json.decode(languagesJson);
    languageList.forEach((item) => languageNames.add(item['name'].toString()));
  }

  changeLanguage(String languageName) {
    final _language = findLanguageByName(languageName);

    currentLanguage = RxMap({
      "code": _language['code'].toString(),
      "name": _language['name'].toString()
    });
  }

  dynamic findLanguageByName(String name) {
    return languageList.firstWhere((language) => language['name'] == name, orElse: () { return null; });
  }

  dynamic findLanguageByCode(String code) {
    return languageList.firstWhere((language) => language['code'] == code, orElse: () { return null; });
  }
}