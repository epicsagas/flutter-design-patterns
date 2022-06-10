import 'dart:developer';

import 'package:get/get.dart';
import 'package:translator/translator.dart';

import './common_controller.dart';

class MarkdownController extends GetxController {
  final String initial = "";
  var description = ''.obs;
  var data = ''.obs;

  final CommonController commonController = Get.put(CommonController());
  final translator = GoogleTranslator();

  setDescription(String _description) async {
    var translated = _description;

    try {
      if (commonController.language.value != "en") {
        final translatedDescription = await translator.translate(_description, from: "en", to: commonController.language.value);
        translated = translatedDescription.text;
      }
    } catch(exception) {
      translated = exception.toString();
    }

    description = RxString(translated);

    update();
  }

  setData(String _data) async {
    var translated = _data;

    try {
      if (commonController.language.value != "en") {
        final translatedData = await translator.translate(_data, from: "en", to: commonController.language.value);
        translated = translatedData.text;
      }
    } catch(exception) {
      translated = exception.toString();
    }

    data = RxString(translated);

    update();
  }

  reset() async {
    description = RxString(initial);
    data = RxString(initial);

    update();
  }
}