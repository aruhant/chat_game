import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/messages/messages_list.dart';
import 'package:chat-game/pages/widgets/drawer.dart';
import 'package:chat-game/providers/storage_provider.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  Widget build(BuildContext context) {
    return DrawerWidget(
        title: 'Developer Settings',
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 40),
                Btn(
                    onPressed: () => SaveStorage.clear(),
                    label: 'Clear Database'),
                Row(
                  children: [
                    Text('Autoplay: '),
                    Switch(
                        value: Settings.i.autoplay,
                        onChanged: (value) {
                          Settings.i.autoplay = value;
                          setState(() => Settings.save());
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        'Autoplay Duration: ${Settings.i.autoplayDelay / 1000} '),
                    Slider(
                        max: 100,
                        min: 0.1,
                        value: Settings.i.autoplayDelay / 1000,
                        onChanged: (value) {
                          Settings.i.autoplayDelay = value.toInt() * 1000;
                          setState(() => Settings.save());
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text('Choice Delay: ${Settings.i.choiceDelay / 1000}'),
                    Slider(
                        max: 100,
                        min: 0.1,
                        value: Settings.i.choiceDelay / 1000,
                        onChanged: (value) {
                          Settings.i.choiceDelay = value.toInt() * 1000;
                          setState(() {
                            Settings.save();
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
