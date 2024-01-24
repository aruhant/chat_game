import 'package:chat-game/providers/storage_provider.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:isar/isar.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:jenny/src/structure/dialogue_line.dart';
import 'package:uuid/uuid.dart';

part 'message.g.dart';

@collection
class Message {
  Id get iid => fastHash(id);
  @Index(type: IndexType.value)
  String conversationID;
  String? text;
  String? attachment;
  String? character;
  int createdAt;
  String id;
  @Index(type: IndexType.value)
  String storyName;
  @enumerated
  MessageType messageType;

  Message(
      {this.text,
      required this.storyName,
      this.attachment,
      this.character,
      required this.createdAt,
      required this.conversationID,
      required this.id,
      required this.messageType});

  @ignore
  types.Message toMessage(String userName) {
    if (messageType == MessageType.image)
      return types.ImageMessage(
        author: getUser(character, userName),
        createdAt: createdAt,
        id: id,
        name: attachment!,
        size: 100,
        uri: '${attachment}',
      );
    if (character == null)
      return types.SystemMessage(
        createdAt: createdAt,
        id: id,
        text: text!.replaceAll('_USER_', userName),
      );
    return types.TextMessage(
      author: getUser(character, userName),
      createdAt: createdAt,
      id: id,
      text: text!.replaceAll('_USER_', userName),
    );
  }

  types.User getUser(String? character, String userName) {
    return types.User(
        firstName: (character ?? '')
            .replaceAll('_User_', userName)
            .replaceAll('__', '.')
            .replaceAll('_', ' '),
        id: character ?? '');
  }

  factory Message.messageFromLine(
      {required DialogueLine line,
      required String storyName,
      required String conversationID}) {
    if (line.attributes.isNotEmpty && line.attributes[0].name == 'image')
      return Message(
        id: const Uuid().v4(),
        storyName: storyName,
        messageType: MessageType.image,
        conversationID: conversationID,
        character: line.character?.name,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        text: line.text,
        attachment: 'assets/images/${line.text}.jpg',
      );
    return Message(
      id: const Uuid().v4(),
      storyName: storyName,
      conversationID: conversationID,
      character: line.character?.name,
      messageType: MessageType.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: line.text,
    );
  }
}

enum MessageType { text, image }
