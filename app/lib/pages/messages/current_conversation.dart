import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat-game/models/group.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/groups/groups_provider.dart';
import 'package:chat-game/pages/messages/messages_list.dart';
import 'package:chat-game/pages/groups/groups_page.dart';
import 'package:go_router/go_router.dart';
import 'package:chat-game/pages/widgets/drawer.dart';

class CurrentConversation extends ConsumerStatefulWidget {
  const CurrentConversation(
      {super.key, required this.conversationID, required this.storyName});
  final String conversationID, storyName;
  @override
  ConsumerState<CurrentConversation> createState() =>
      _CurrentConversationPaneState();
}

class _CurrentConversationPaneState extends ConsumerState<CurrentConversation> {
  @override
  Widget build(BuildContext context) {
    String activeConversationID =
        widget.conversationID; //?? ref.watch(activeConversationIDProvider);
    Group? conversation = ref.watch(groupProvider(activeConversationID));

    if (conversation == null) {
      Future.delayed(
          Duration(milliseconds: 10),
          () => !mounted
              ? null
              : context.go('/story/${widget.storyName}/conversations'));
      return Container();
    }

    return DrawerWidget(
        title: conversation.title.replaceAll('_USER_', Settings.i.userName),
        image: conversation.image,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                context.go('/story/${widget.storyName}/conversations')),
        child: MessagesList(
            conversation: conversation, storyName: widget.storyName));
  }
}
