import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat-game/models/group.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/groups/groups_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:chat-game/utils/logging.dart';
import 'package:chat-game/game/yarn_provider.dart';
import 'package:photo_view/photo_view.dart';

class MessagesList extends ConsumerStatefulWidget {
  const MessagesList(
      {super.key, required this.conversation, required this.storyName});
  final String storyName;
  final Group conversation;
  final user = const types.User(id: 'You');

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  String userName = 'You';
  @override
  Widget build(BuildContext context) {
    var activeID = ref.watch(activeConversationIDProvider);
    var vars = ref.read(variableStorageProvider);
    userName = Settings.i.userName;

    bool isActive = widget.conversation.id == activeID;
    return Chat(
      theme: DefaultChatTheme(
        systemMessageTheme: SystemMessageTheme(
          margin: EdgeInsets.symmetric(horizontal: 16),
          textStyle: GoogleFonts.raleway(fontSize: 22, color: Colors.black87),
        ),
        receivedMessageBodyTextStyle:
            GoogleFonts.raleway(fontSize: 22, color: Colors.black),
        sentMessageBodyTextStyle:
            GoogleFonts.raleway(fontSize: 22, color: Colors.white),
        backgroundColor: Colors.transparent,
        primaryColor: Theme.of(context).primaryColor,
      ),
      messages: widget.conversation.messages
          .map((e) => e.toMessage(userName))
          .toList(),
      onSendPressed: ((_) {}),
      customBottomWidget:
          isActive ? buildChoices(widget.conversation) : buildBack(activeID),
      user: widget.user,
      showUserAvatars: false,
      showUserNames: true,
      imageMessageBuilder: (types.ImageMessage m, {required int messageWidth}) {
        return GestureDetector(
            onTap: () => context.push('/image', extra: m.uri),
            onDoubleTap: () => context.push('/image', extra: m.uri),
            child: Hero(tag: m.uri, child: Image.asset(m.uri)));
      },
      disableImageGallery: true,
    );
  }

  Widget buildChoices(Group conversation) {
    if (conversation.textInputCompleter != null) {
      String inputValue = '';
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: TextField(
          textInputAction: TextInputAction.go,
          onChanged: (value) => inputValue = value,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20),
              suffixIcon: Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 6, top: 4, bottom: 4),
                child: MaterialButton(
                  minWidth: 20,
                  height: 20,
                  padding: const EdgeInsets.all(0),
                  color: Theme.of(context).primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  textColor: Colors.white,
                  child: Icon(Icons.send),
                  onPressed: () =>
                      conversation.textInputCompleter?.complete(inputValue),
                ),
              ),
              border: const OutlineInputBorder(),
              hintText: 'Enter your name here'),
          onSubmitted: (value) =>
              conversation.textInputCompleter?.complete(value),
        ),
      );
    }

    if (conversation.choice == null)
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Btn(
                icon: Icons.touch_app,
                onPressed: () => conversation.nextCompleter?.complete(false),
              ),
            ),
          ),
        ],
      );
    return Row(children: [
      for (int i = 0; i < conversation.choice!.options.length; i++)
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Btn(
                  onPressed: () => conversation.choiceCompleter?.complete(i),
                  label: conversation.choice!.options[i].text)),
        )
    ]);
  }

  buildBack(String activeID) {
    if (activeID == 'EOF') return Container();
    String title =
        ref.read(conversationsProvider).getConversation(activeID)?.title ??
            'Conversation';
    if (Settings.i.autoplay)
      Future.delayed(Duration(milliseconds: Settings.i.autoplayDelay ~/ 2))
          .then((value) =>
              context.go('/story/${widget.storyName}/messages/${activeID}'));
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Btn(
                onPressed: () =>
                    context.go('/story/${widget.storyName}/conversations'),
                label: 'Continue to ${title.replaceAll('_USER_', userName)}'),
          ),
        ),
      ],
    );
  }
}

class Btn extends StatelessWidget {
  const Btn({super.key, required this.onPressed, this.label, this.icon});

  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(
            child: (icon == null)
                ? AutoSizeText(label ?? '',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.raleway(fontSize: 16, color: Colors.white),
                    minFontSize: 2,
                    maxLines: 2)
                : Icon(Icons.touch_app)),
      ),
    );
  }
}
