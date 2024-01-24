import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/group.dart';
import 'package:chat-game/pages/groups/groups_provider.dart';
import 'package:chat-game/providers/storage_provider.dart';
import '../utils/logging.dart';

FutureOr<void> switchConversationCommand(
    {required Ref ref, required String id}) {
  ref.read(activeConversationIDProvider.notifier).state = id;
  Log.i('Switching active id to $id');
}

FutureOr<void> getTextCommand({required Ref ref, required String name}) {
  Group? active = ref
      .read(conversationsProvider)
      .getConversation(ref.read(activeConversationIDProvider));
  if (active == null)
    return Log.e('No active conversation for $activeConversationIDProvider');
  Log.i('Reading variable $name');
  return active.getTextInput(ref, name);
}

FutureOr<void> conversationCommand(
    {required Ref ref,
    required String id,
    required String titles,
    required String storyName,
    required String image}) {
  Conversations conversations = ref.read(conversationsProvider);
  {
    String title = titles.split('~')[0];
    String subtitle = (titles == title) ? '' : titles.split('~')[1];
    Group group;
    group = conversations.update(id,
        title: title, subtitle: subtitle, image: image, storyName: storyName);
    saveGroup(group);
  }

  ref.read(activeConversationIDProvider.notifier).state = id;
  Log.i('setting active id to $id');
}

void saveGroup(Group group) {
  var isar = SaveStorage.isar;
  return isar.writeTxnSync(() => isar.groups.putSync(group));
}
