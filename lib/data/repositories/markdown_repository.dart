import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../store/store.dart';

final markdownRepositoryProvider = Provider(
  (ref) => const MarkdownRepository(),
);

final markdownProvider = FutureProvider.autoDispose.family<String, String>(
  (ref, id) => ref.watch(markdownRepositoryProvider).get(id),
);

class MarkdownRepository {
  const MarkdownRepository();

  Future<String> get(String designPatternId) async {
    final Store store = Get.find();
    final path = '${AssetConstants.markdownPath}$designPatternId.md';
    final markdownString = await rootBundle.loadString(path);

    await store.md.setData(markdownString);

    return store.md.description.value;
  }
}
