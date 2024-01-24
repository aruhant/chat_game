import 'package:chat-game/providers/storage_provider.dart';
import 'package:isar/isar.dart';

part 'settings.g.dart';

@collection
class Settings {
  Id get iid => 0;
  bool debugMode;
  bool showMenu;
  bool autoplay;
  int autoplayDelay;
  int choiceDelay;
  String userName, userAvatar, lastPath;

  Settings(
      {this.debugMode = false,
      this.userName = 'Player 1',
      this.userAvatar = 'USERAVATAR',
      this.showMenu = false,
      this.lastPath = '/intro',
      this.autoplay = false,
      this.autoplayDelay = 1000,
      this.choiceDelay = 10000});

  @ignore
  static Settings i = Settings();
  static save() {
    SaveStorage.isar.writeTxnSync(() => SaveStorage.isar.settings.putSync(i));
  }

  static load(Isar isar) {
    Settings.i = isar.settings.getSync(0) ?? Settings();
  }
}
