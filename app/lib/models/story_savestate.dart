import 'package:chat-game/models/group.dart';
import 'package:chat-game/models/message.dart';
import 'package:chat-game/providers/storage_provider.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:isar/isar.dart';

part 'story_savestate.g.dart';

@collection
class StorySaveState {
  Id get iid => fastHash(id);
  @Index(type: IndexType.value)
  String conversationID;
  String node;
  String id;
  int messageCount;
  int conversationCount;
  @enumerated
  StorySaveState(
      {required this.conversationID,
      required this.conversationCount,
      required this.messageCount,
      required this.id,
      required this.node});
  @ignore
  Map<String, Group> get conversations {
    var isar = SaveStorage.isar;
    late List<Message> messages;
    late List<Group> conversations;
    isar.writeTxnSync(() {
      conversations = isar.groups.where().storyNameEqualTo(id).findAllSync()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      messages = isar.messages.where().storyNameEqualTo(id).findAllSync()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      for (int i = 0; i < conversations.length - conversationCount; i++) {
        Log.d('Deleting ${conversations[i].title}');
        isar.groups.deleteSync(conversations[i].iid);
      }

      for (int i = 0; i < messages.length - messageCount; i++) {
        Log.d('Deleting ${messages[i].text}');
        isar.messages.deleteSync(messages[i].iid);
      }

      conversations =
          conversations.sublist(conversations.length - conversationCount);
      messages = messages.sublist(messages.length - messageCount);
    });

    Map<String, Group> map = {};
    for (var c in conversations) {
      map[c.id] = c;
    }
    Log.d('Adding ${messages.length} messages to ${map.length} conversations');
    for (var m in messages) {
      if (!map.containsKey(m.conversationID)) {
        Log.e('No conversation for ${m.conversationID}');
        continue;
      } else
        map[m.conversationID]!.messages.add(m);
    }
    return map;
  }

  String restart() {
    var isar = SaveStorage.isar;
    isar.writeTxnSync(() {
      isar.groups.where().storyNameEqualTo(id).deleteAllSync();
      isar.messages.where().storyNameEqualTo(id).deleteAllSync();
    });
    return 'Start';
  }
}
