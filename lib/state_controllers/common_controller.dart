import 'package:get/get.dart';

class CommonController extends GetxController {
  var language = "en".obs;

  changeLanguage(String changeTo) {
    language = RxString(changeTo);
  }
}