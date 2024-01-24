import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:chat-game/providers/shared_prefs.dart';
import 'package:chat-game/providers/storage_provider.dart';
import 'package:chat-game/providers/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../router/router.dart';
import 'utils/logging.dart';
import 'utils/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

const emulatorHost = '192.168.1.138';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  SaveStorage.isar;
  SaveStorage.clear();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final Color themeColor = SharedPrefs.themeColor;
  await initializeDateFormatting();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // initRemoteConfig();

  if (emulatorHost != null) {
    Log.i('Using emulator');

    // await FirebaseAuth.instance.useAuthEmulator(emulatorHost, 8080);
  } else {
    Log.i('Using Live servers');
  }
  runApp(ProviderScope(
      child: AdaptiveTheme(
          initial: savedThemeMode ?? AdaptiveThemeMode.light,
          light: makeTheme(themeColor, false),
          dark: makeTheme(themeColor, true),
          builder: (theme, darkTheme) => Container(
                color: savedThemeMode == AdaptiveThemeMode.light
                    ? Colors.white
                    : Colors.black,
                child: MaterialApp.router(
                  theme: theme,
                  darkTheme: darkTheme,
                  routerConfig: router,
                ),
              ))));
}
