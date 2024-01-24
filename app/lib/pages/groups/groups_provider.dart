import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/group.dart';
import 'package:chat-game/models/story.dart';
import 'package:chat-game/utils/logging.dart';

class Conversations extends ChangeNotifier {
  final Map<String, Group> _conversations = {};

  bool get isEmpty => _conversations.isEmpty;

  get length => _conversations.length;

  get values => _conversations.values;
  Group? getConversation(id) => _conversations[id];

  void clear() {
    _conversations.clear();
    notifyListeners();
  }

  void addAll(Map<String, Group> conversations) {
    _conversations.addAll(conversations);
    notifyListeners();
  }

  bool containsKey(String id) => _conversations.containsKey(id);

  Group update(String id,
      {required String title,
      required String subtitle,
      required String storyName,
      required String image}) {
    Group? group = _conversations[id];
    if (group == null)
      _conversations[id] = group = Group(
          title: title,
          storyName: storyName,
          subtitle: subtitle,
          id: id,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          image: image,
          messageList: []);
    else
      group.update(title: title, subtitle: subtitle, image: image);
    notifyListeners();
    return group;
  }

  @override
  String toString() {
    return _conversations.toString();
  }

  FutureOr<void> set(String id, Group group) {}
}

final _conversations = Conversations();

final conversationsProvider = ChangeNotifierProvider<Conversations>((ref) {
  return _conversations;
});

final groupProvider = ChangeNotifierProvider.family<Group?, String>((ref, id) {
  return _conversations.getConversation(id);
});
final activeConversationIDProvider = StateProvider<String>((ref) => '');
final activeStoryProvider = StateProvider<Story?>((ref) => null);
// final activeConversationProvider = StateProvider<Group>((ref) =>
//     ref.read(conversationsProvider)[ref.watch(activeConversationIDProvider)]!);
// final selectedConversationIDProvider = StateProvider<String>((ref) => '');
