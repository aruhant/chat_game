import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/providers/storage_provider.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:chat-game/game/yarn_provider.dart';
import 'package:jenny/src/character.dart';
import 'package:jenny/src/structure/dialogue_choice.dart';
import 'package:jenny/src/structure/dialogue_line.dart';
import 'package:chat-game/models/message.dart';
import 'package:isar/isar.dart';

part 'group.g.dart';

@collection
class Group extends ChangeNotifier {
  @ignore
  DialogueChoice? choice;
  @ignore
  Completer<int>? choiceCompleter;
  @ignore
  Completer<bool>? nextCompleter;

  @ignore
  Completer<String>? textInputCompleter;

  Id get iid => fastHash(id);

  Group(
      {required this.id,
      required this.title,
      required this.storyName,
      required this.subtitle,
      required this.createdAt,
      List<Message>? messageList,
      required this.image})
      : messages = messageList ?? [];
  String title;
  @Index(type: IndexType.value)
  final String storyName;
  final String id;
  String image;
  final int createdAt;
  String subtitle;
  @ignore
  List<Message> messages;

  update({String? title, String? subtitle, String? image}) {
    this.title = title ?? this.title;
    this.subtitle = subtitle ?? this.subtitle;
    this.image = image ?? this.image;
    notifyListeners();
  }

  Message addMessage(DialogueLine line) {
    var message = Message.messageFromLine(
        line: line, conversationID: id, storyName: storyName);
    messages.insert(0, message);
    choice = null;
    notifyListeners();
    return message;
  }

  @override
  String toString() =>
      'Group($id, $title, $storyName, $subtitle, $image, ${messages.length})';

  types.User getUser(Character? character) {
    return types.User(
        firstName: character?.name ?? '', id: character?.name ?? '');
  }

  void setChoice(DialogueChoice choice, Completer<int> completer) {
    this.choice = choice;
    this.choiceCompleter = completer;
    notifyListeners();
  }

  void setNext(Completer<bool> next) => this.nextCompleter = next;

  @override
  void dispose() {
    Log.w('Group dispose $id');
    super.dispose();
  }

  Future getTextInput(Ref ref, String name) {
    var completer = Completer<String>();
    textInputCompleter = Completer<String>();
    textInputCompleter!.future.then((value) {
      Log.d('textInputCompleter $value');
      textInputCompleter = null;
      ref.read(variableStorageProvider).setVariable('\$$name', value);
      Settings.i.userName = value;
      Settings.i.showMenu = true;
      Settings.save();
      completer.complete(value);
    });
    notifyListeners();
    return completer.future;
  }
}
