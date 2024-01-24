import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/image/image_viewer.dart';
import 'package:chat-game/pages/into/intro.dart';
import 'package:chat-game/pages/profile/profile.dart';
import 'package:chat-game/pages/stories/stories_widget.dart';
import 'package:chat-game/pages/groups/groups_page.dart';
import 'package:chat-game/pages/messages/current_conversation.dart';
import 'package:chat-game/pages/widgets/story_runner.dart';
import 'package:chat-game/providers/iap.dart';
import 'package:chat-game/pages/debug/debug.dart';

final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Settings.i.lastPath,
    routes: [
      GoRoute(path: '/', builder: (context, state) => StoriesPage()),
      GoRoute(path: '/intro', builder: (context, state) => IntroPage()),
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      GoRoute(
        path: '/story/:story',
        builder: (context, state) => StoryRunner(story: state.params['story']!),
      ),
      GoRoute(
        path: '/image',
        builder: (context, state) => ImageViewer(url: state.extra.toString()),
      ),
      GoRoute(
          path: '/iap', builder: (context, state) => Material(child: IAP())),
      GoRoute(path: '/developer', builder: (context, state) => DebugPage()),
      GoRoute(
          path: '/story/:story/conversations',
          builder: (context, state) => GroupsWidget(
              storyName: state.params['story']!,
              title: 'Contacts')),
      GoRoute(
          path: '/story/:story/messages/:conversationID',
          builder: (context, state) => CurrentConversation(
              storyName: state.params['story']!,
              conversationID: state.params['conversationID'] as String)),
    ]);
