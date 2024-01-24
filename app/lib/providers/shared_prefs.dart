// singleton class for shared preferences

import 'package:flutter/material.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:jenny/src/variable_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;
  // static SharedPreferences get prefs => _prefs!;

  static Future<void> init() async =>
      _prefs = loadDefaults(await SharedPreferences.getInstance());

  static Color themeColor = Color(_prefs!.getInt('ThemeColor') ?? 0xFF880E4F);

  static void loadVariables(VariableStorage variableStorage) {
    for (String key in _prefs!.getKeys()) {
      if (key.startsWith('\$'))
        variableStorage.setVariable(key, _prefs!.getString(key));
    }
    Log.d('Loaded variables: ${variableStorage.variables}');
  }

  static SharedPreferences? loadDefaults(SharedPreferences sharedPreferences) {
    return sharedPreferences;
  }

  static getString(String s) => _prefs!.getString(s);
  static setString(String s, String v) => _prefs!.setString(s, v);
}
