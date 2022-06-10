import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../data/models/design_pattern.dart';
import '../../../../data/repositories/markdown_repository.dart';
import '../../../../themes.dart';
import '../../../state_controllers/markdown_controller.dart';

class MarkdownView extends ConsumerWidget {
  final DesignPattern designPattern;

  const MarkdownView({
    required this.designPattern,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdown = ref.watch(markdownProvider(designPattern.id));
    final MarkdownController mdController = Get.put(MarkdownController());

    mdController.setDescription(designPattern.description);

    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(LayoutConstants.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              mdController.description.value,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 99,
            ),
            const SizedBox(height: LayoutConstants.spaceL),
            markdown.when(
              data: (data) => MarkdownBody(
                data: mdController.data.value,
                fitContent: false,
                selectable: true,
              ),
              loading: () => Center(
                child: CircularProgressIndicator(
                  backgroundColor: lightBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black.withOpacity(0.65),
                  ),
                ),
              ),
              error: (_, __) => const Text('Oops, something went wrong...'),
            ),
          ],
        ),
      ),
    );
  }
}
