import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/stories/slider.dart';
import 'package:chat-game/providers/catalog_provider.dart';
import 'package:chat-game/pages/widgets/drawer.dart';

class StoriesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(catalogProvider);
    Settings.i.lastPath = '/';
    Settings.save();
    return catalog.when(
        data: (catalog) {
          // return CoverSlider(stories: catalog.stories);
          return DrawerWidget(
              title: 'Adventures',
              child: CoverSlider(stories: catalog.stories));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error')));
  }
}
