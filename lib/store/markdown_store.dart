import 'package:get/get.dart';
import 'package:translator/translator.dart';

class MarkdownStore extends GetxController {
  final String initial = "";
  RxString description = ''.obs;
  RxString data = ''.obs;
  RxString descriptionTranslated = ''.obs;
  RxString dataTranslated = ''.obs;
  final translator = GoogleTranslator();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> setDescription(String _description) async {
    description = RxString(_description);
    update();
  }

  Future<void> setData(String _data) async {
    data = RxString(_data);
    update();
  }

  Future<void> translateDescription({String languageCode = "en"}) async {
    String translated = description.value;

    if (languageCode != "en") {
      try {
        final translatedDescription = await translator.translate(
          description.value,
          from: "en",
          to: languageCode,
        );

        translated = translatedDescription.text;
      } catch(exception) {
        translated = exception.toString();
      }
    }

    descriptionTranslated = RxString(translated);
    update();
  }

  Future<void> translateData({String languageCode = "en"}) async {
    String translated = data.value;

    if (languageCode != "en") {
      try {
        final translatedData = await translator.translate(
          data.value,
          from: "en",
          to: languageCode,
        );

        translated = translatedData.text;
      } catch(exception) {
        translated = exception.toString();
      }
    }

    dataTranslated = RxString(translated);
    update();
  }

  Future<void> reset() async {
    description = RxString(initial);
    data = RxString(initial);
    descriptionTranslated = RxString(initial);
    dataTranslated = RxString(initial);

    update();
  }
}