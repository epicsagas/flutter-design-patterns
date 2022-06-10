
import 'package:get/get.dart';
import 'package:translator/translator.dart';

import './language_controller.dart';

class MarkdownController extends GetxController {
  final String initial = "";
  RxString description = ''.obs;
  RxString data = ''.obs;

  final LanguageController languageController = Get.put(LanguageController());
  final translator = GoogleTranslator();

  setDescription(String _description) async {
    var translated = _description;
    final currentLanguageCode = languageController.currentLanguage['code'].toString();
    try {
      if (currentLanguageCode != "en") {
        final translatedDescription = await translator.translate(
            _description,
            from: "en",
            to: currentLanguageCode,
        );
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
    final currentLanguageCode = languageController.currentLanguage['code'].toString();
    try {
      if (currentLanguageCode != "en") {
        final translatedData = await translator.translate(
            _data,
            from: "en",
            to: currentLanguageCode,
        );
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