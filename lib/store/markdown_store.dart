import 'dart:developer';

import 'package:get/get.dart';
import 'package:translator/translator.dart';

import 'language_store.dart';

class MarkdownStore extends GetxController {
  final String initial = "";
  RxString description = ''.obs;
  RxString data = ''.obs;
  RxString descriptionTranslated = ''.obs;
  RxString dataTranslated = ''.obs;

  final translator = GoogleTranslator();
  final languageStore = Get.find<LanguageStore>();

  @override
  Future<void> onInit() async {
    languageStore.currentLanguage.listen((value) async {
      if (value.containsKey('code')) {
        final languageCode = value['code'].toString();

        if (languageCode == "en") {
          descriptionTranslated.value = description.value;
          dataTranslated.value = data.value;
        } else {
          descriptionTranslated.value = await translate(languageCode: languageCode, data: description.value);
          dataTranslated.value = await translate(languageCode: languageCode, data: data.value);
        }
      }
    });

    description.listen((value) async {
      if (value.isNotEmpty && languageStore.currentLanguage.containsKey('code')) {
        descriptionTranslated.value = await translate(languageCode: languageStore.currentLanguage['code'].toString(), data: value);
      } else {
        descriptionTranslated.value = '';
      }
    });

    data.listen((value) async {
      if (value.isNotEmpty && languageStore.currentLanguage.containsKey('code')) {
        dataTranslated.value = await translate(languageCode: languageStore.currentLanguage['code'].toString(), data: value);
      } else {
        dataTranslated.value = '';
      }
    });

    super.onInit();
  }

  Future<String> translate({String languageCode = "en", String data = ""}) async {
    try {
      final translated = await translator.translate(
        data,
        from: "en",
        to: languageCode,
      );

      return translated.text;
    } catch(exception) {
      return exception.toString();
    }
  }

  Future<void> reset() async {
    description.value = '';
    data.value = '';
  }
}