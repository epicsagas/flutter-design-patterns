import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../state_controllers/markdown_controller.dart';

final markdownRepositoryProvider = Provider(
  (ref) => const MarkdownRepository(),
);

final markdownProvider = FutureProvider.autoDispose.family<String, String>(
  (ref, id) => ref.watch(markdownRepositoryProvider).get(id),
);

class MarkdownRepository {
  const MarkdownRepository();

  Future<String> get(String designPatternId) async {
    final path = '${AssetConstants.markdownPath}$designPatternId.md';
    final markdownString = await rootBundle.loadString(path);
    final MarkdownController mdController = Get.put(MarkdownController());

    await mdController.setData(markdownString);

    return mdController.description.value;
  }
}
