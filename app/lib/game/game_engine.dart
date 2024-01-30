/*
  This file contains the main game engine. It is responsible for handling the
  game's logic and state.
*/
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

// The ChatDialogueView handles processing all the dialogue in the game along
// with related actions
class ChatDialogueView extends DialogueView {
  // The ref is a reference to the current context
  final Ref ref;
  final String storyName;
  // The constructor takes a reference to the current context and the story name
  ChatDialogueView(this.ref, this.storyName);
  final Isar isar = SaveStorage.isar;
  // The onLineStart method is called when a new line of dialogue is started
  /*IMPRESSIVE CODE SNIPET*/
  @override
  FutureOr<bool> onLineStart(DialogueLine line) {
    Log.d(line.text);
    Completer<bool> c = Completer<bool>();
    if (line.text.isEmpty) return false;
    // Get the active conversation
    String conversationID = ref.read(activeConversationIDProvider);
    Group? activeConversation = ref.read(groupProvider(conversationID));
    // If there is no active conversation, log an error
    if (activeConversation == null)
      Log.e('No active conversation for ${line.text} ${conversationID}');
    else {
      activeConversation.setNext(c);
      saveMessage(activeConversation.addMessage(line));
    }
    // If autoplay is enabled, delay the completion of the line
    if (Settings.i.autoplay)
      Future.delayed(Duration(milliseconds: Settings.i.autoplayDelay))
          .then((value) => c.isCompleted ? null : c.complete(false));
    return c.future;
  }
  /*IMPRESSIVE CODE SNIPET*/

  // The onChoiceStart method is called when a new choice is made
  @override
  FutureOr<int?> onChoiceStart(DialogueChoice choice) {
    String conversationID = ref.read(activeConversationIDProvider);
    Group? activeConversation = ref.read(groupProvider(conversationID));
    Completer<int> c = Completer<int>();
    // If there is no active conversation, log an error
    if (activeConversation == null)
      Log.e('No active conversation for $choice in ${conversationID}');
    else {
      activeConversation.setChoice(choice, c);
    }
    // If autoplay is enabled, delay the completion of the choice
    if (Settings.i.autoplay)
      Future.delayed(Duration(milliseconds: Settings.i.choiceDelay)).then(
          (value) => c.isCompleted
              ? null
              : c.complete(Random().nextInt(choice.options.length)));
    return c.future;
  }

  // The onNodeStart method is called when a new node (a new part of the story)
  // is started
  @override
  FutureOr<void> onNodeStart(Node node) {
    Log.d('Saving');
    // Get the active conversation
    String conversationID = ref.read(activeConversationIDProvider);
    // Save the current state of the story
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

// The saveMessage method saves a message to the database
  StorySaveState? get _savedState => SaveStorage.isar.storySaveStates
      .where()
      .iidEqualTo(fastHash(storyName))
      .findFirstSync();
  // The saveMessage method saves a message to the database
  void saveMessage(Message message) =>
      isar.writeTxnSync(() => isar.messages.putSync(message));
  // The loadSavedState method loads the saved state of a previous story
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
    // Return the saved node of the story
    return savedState.node;
  }

  // The resetViews method resets the views which are currently active
  void resetViews() {
    Log.d('reset Views...');
    ref.read(activeConversationIDProvider.notifier).state = '';
    ref.read(conversationsProvider).clear();
    ref.invalidate(groupProvider);
  }
}
