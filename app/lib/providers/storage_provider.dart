import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/group.dart';
import 'package:chat-game/models/message.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/models/story_savestate.dart';
import 'package:isar/isar.dart';

class SaveStorage {
  static Isar? _isar;
  static Isar get isar {
    if (_isar == null) {
      _isar = Isar.openSync(
          [MessageSchema, GroupSchema, SettingsSchema, StorySaveStateSchema]);
      Settings.load(_isar!);
    }
    return _isar!;
  }

  static void clear() {
    _isar!.writeTxnSync(() => _isar!.clearSync());
    Settings.save();
  }
}

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;
  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }
  return hash;
}
