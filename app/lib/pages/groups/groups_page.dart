import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chat-game/models/settings.dart';
import 'groups_provider.dart';
import 'package:chat-game/pages/widgets/avatar.dart';
import 'package:chat-game/pages/widgets/drawer.dart';
import 'package:chat-game/models/group.dart';

class GroupsWidget extends ConsumerStatefulWidget {
  const GroupsWidget({super.key, required this.storyName, required this.title});
  final String title, storyName;
  @override
  ConsumerState<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends ConsumerState<GroupsWidget> {
  @override
  Widget build(BuildContext context) {
    Conversations conversations = ref.watch(conversationsProvider);
    String active = ref.watch(activeConversationIDProvider);
    if (conversations.isEmpty) return Container();
    return DrawerWidget(
        title: widget.title,
        child: Stack(
          children: [
            makeFooter(ref.watch(activeStoryProvider)?.title ?? ''),
            ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  Group conversation = conversations.values.toList()[index];
                  return InkWell(
                    onTap: () => context.go(
                        '/story/${widget.storyName}/messages/${conversation.id}'),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                  style: BorderStyle.solid))),
                      child: Row(
                        children: [
                          Avatar(
                            image: conversation.image,
                            animate: conversation.id == active,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  conversation.title.replaceAll(
                                      '_USER_', Settings.i.userName),
                                  style: TextStyle(fontSize: 20)),
                              Text(
                                  conversation.subtitle.replaceAll(
                                      '_USER_', Settings.i.userName),
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ));
  }

  Align makeFooter(String text) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
