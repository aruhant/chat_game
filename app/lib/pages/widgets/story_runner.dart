import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/models/story.dart';
import 'package:chat-game/pages/groups/groups_provider.dart';
import 'package:chat-game/providers/catalog_provider.dart';
import 'package:jenny/jenny.dart';
import 'package:chat-game/game/yarn_provider.dart';
import 'package:go_router/go_router.dart';

class StoryRunner extends ConsumerStatefulWidget {
  final String story;
  const StoryRunner({super.key, required this.story});

  @override
  ConsumerState<StoryRunner> createState() => _StoryRunnerState();
}

class _StoryRunnerState extends ConsumerState<StoryRunner> {
  late DialogueRunner runner;
  @override
  void initState() {
    ref.read(catalogProvider).whenData((catalog) {
      var story =
          catalog.stories.firstWhere((element) => element.id == widget.story);
      Future.delayed(Duration(milliseconds: 10)).then(
          (value) => ref.read(activeStoryProvider.notifier).state = story);
    });
    ref.read(yarnEngineProvider(widget.story)).whenData((e) => e.start());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String active = ref.watch(activeConversationIDProvider);
    if (active.isNotEmpty)
      Future.delayed(Duration(milliseconds: 10), () {
        !mounted ? null : context.go('/story/${widget.story}/messages/$active');
        Settings.i.lastPath = '/story/${widget.story}';
        Settings.save();
      });
    var catalog = ref.read(catalogProvider);
    return catalog.when(
        data: (catalog) {
          return loadingScreen(catalog.stories
              .firstWhere((element) => element.id == widget.story));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => const Center(child: Text('Error')));
  }

  Widget loadingScreen(Story story) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(story.cover),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(story.title),
            Text(story.subtitle),
          ],
        ),
      ),
    );
  }
}
