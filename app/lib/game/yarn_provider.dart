import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/providers/shared_prefs.dart';
import 'package:chat-game/utils/logging.dart';
import 'game_engine.dart';
import 'commands.dart';
import 'package:jenny/jenny.dart';
import 'dart:async';

late VariableStorage _variableStorage;

class YarnEngine {
  String name;
  AutoDisposeFutureProviderRef<YarnEngine> ref;
  late YarnProject _yarn;
  bool _started = false;
  late DialogueRunner _runner;
  late ChatDialogueView _chatDialogueView;
  YarnEngine(this.ref, this.name) {
    Log.w('Creating yarn engine for $name');
    _yarn = YarnProject()
      ..functions.addFunction1<int, String>(
          'length', (a) => a == null ? 0 : '$a'.length)
      ..functions.addFunction0<String>('getUserName', () => Settings.i.userName)
      ..commands.addCommand3(
          'conversation',
          (String id, String titles, String image) => conversationCommand(
              ref: ref, id: id, titles: titles, image: image, storyName: name))
      ..commands.addCommand1(
          'switch', (String id) => switchConversationCommand(ref: ref, id: id))
      ..commands.addCommand1(
          'getText', (String name) => getTextCommand(ref: ref, name: name))
      ..strictCharacterNames = false;
    _variableStorage = _yarn.variables;
    SharedPrefs.loadVariables(_variableStorage);
    _chatDialogueView = ChatDialogueView(ref, name);
    _runner =
        DialogueRunner(yarnProject: _yarn, dialogueViews: [_chatDialogueView]);

    // ..functions.addFunction0('money', player.getMoney)
    // ..commands.addCommand1('achievement', player.earnAchievement)
  }

  Future<String> _readFile(String s) async {
    return await rootBundle.loadString('assets/$s.yarn');
  }

  start() async {
    if (_started) return;
    _started = true;
    _yarn..parse(await _readFile(name));
    _chatDialogueView.resetViews();
    String startNode = _chatDialogueView.loadSavedState(name);
    Log.d('Starting $name at $startNode');
    return _runner..startDialogue(startNode);
  }
}

final yarnEngineProvider = FutureProvider.family
    .autoDispose<YarnEngine, String>((ref, name) => YarnEngine(ref, name));

final variableStorageProvider =
    Provider.autoDispose<VariableStorage>((ref) => _variableStorage);
