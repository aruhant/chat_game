import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/message.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/models/story_savestate.dart';
import 'package:chat-game/pages/groups/groups_provider.dart';
import 'package:chat-game/providers/storage_provider.dart';
import 'package:chat-game/models/group.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:jenny/jenny.dart';
import 'dart:async';
import 'package:isar/isar.dart';

class ChatDialogueView extends DialogueView {
  final Ref ref;
  final String storyName;
  ChatDialogueView(this.ref, this.storyName);
  final Isar isar = SaveStorage.isar;

  @override
  FutureOr<bool> onLineStart(DialogueLine line) {
    Log.d(line.text);
    Completer<bool> c = Completer<bool>();
    if (line.text.isEmpty) return false;
    String conversationID = ref.read(activeConversationIDProvider);
    Group? activeConversation = ref.read(groupProvider(conversationID));
    if (activeConversation == null)
      Log.e('No active conversation for ${line.text} ${conversationID}');
    else {
      activeConversation.setNext(c);
      saveMessage(activeConversation.addMessage(line));
    }
    if (Settings.i.autoplay)
      Future.delayed(Duration(milliseconds: Settings.i.autoplayDelay))
          .then((value) => c.isCompleted ? null : c.complete(false));
    return c.future;
  }

  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) {
    String conversationID = ref.read(activeConversationIDProvider);
    Group? activeConversation = ref.read(groupProvider(conversationID));
    Completer<int> c = Completer<int>();

    if (activeConversation == null)
      Log.e('No active conversation for $choice in ${conversationID}');
    else {
      activeConversation.setChoice(choice, c);
    }
    if (Settings.i.autoplay)
      Future.delayed(Duration(milliseconds: Settings.i.choiceDelay)).then(
          (value) => c.isCompleted
              ? null
              : c.complete(Random().nextInt(choice.options.length)));
    return c.future;
  }

  @override
  FutureOr<void> onNodeStart(Node node) {
    Log.d('Saving');
    String conversationID = ref.read(activeConversationIDProvider);

    isar.writeTxnSync(() {
      int messageCount =
          isar.messages.where().storyNameEqualTo(storyName).countSync();
      int conversationCount =
          isar.groups.where().storyNameEqualTo(storyName).countSync();
      return isar.storySaveStates.putSync(StorySaveState(
          conversationID: conversationID,
          id: storyName,
          messageCount: messageCount,
          conversationCount: conversationCount,
          node: node.title));
    });
    return super.onNodeStart(node);
  }

  StorySaveState? get _savedState => SaveStorage.isar.storySaveStates
      .where()
      .iidEqualTo(fastHash(storyName))
      .findFirstSync();

  void saveMessage(Message message) =>
      isar.writeTxnSync(() => isar.messages.putSync(message));

  String loadSavedState(String name) {
    StorySaveState? savedState = _savedState;
    if (savedState == null || savedState.node == 'EOF')
      return savedState?.restart() ?? 'Start';

    Log.i('Loading Saved State...');
    Conversations conversations = ref.read(conversationsProvider);
    conversations.clear();
    conversations.addAll(_savedState!.conversations);
    ref.read(activeConversationIDProvider.notifier).state =
        savedState.conversationID;

    Log.d('Will start at ${savedState.node}');
    return savedState.node;
  }

  void resetViews() {
    Log.d('reset Views...');
    ref.read(activeConversationIDProvider.notifier).state = '';
    ref.read(conversationsProvider).clear();
    ref.invalidate(groupProvider);
  }
}
