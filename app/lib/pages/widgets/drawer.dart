import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat-game/models/settings.dart';
import 'package:chat-game/pages/widgets/avatar.dart';
import 'package:chat-game/providers/shared_prefs.dart';
import 'package:chat-game/providers/storage_provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart' as UL;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

GlobalKey<ScaffoldState>? _scaffoldKey;

class DrawerWidget extends ConsumerStatefulWidget {
  const DrawerWidget(
      {super.key,
      required this.title,
      this.image,
      this.leading,
      required this.child});
  final Widget child;
  final String title;
  final String? image;
  final Widget? leading;

  @override
  ConsumerState<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends ConsumerState<DrawerWidget> {
  PackageInfo? packageInfo;
  int tap = 0;
  @override
  void initState() {
    PackageInfo.fromPlatform()
        .then((value) => setState(() => packageInfo = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                // begin: Alignment.topLeft,
                // end: Alignment.bottomRight,
                colors: GradientColors.snowAgain)),
        child: Scaffold(
            extendBody: true,
            key: _scaffoldKey = GlobalObjectKey<ScaffoldState>(widget.child),
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            drawer: makeDrawer(context),
            appBar: makeAppBar(),
            body: widget.child),
      ),
    );
  }

  makeDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: () => context.go('/profile'),
            child: UserAccountsDrawerHeader(
                accountName: AutoSizeText(Settings.i.userName,
                    maxLines: 1, style: TextStyle(fontSize: 30)),
                accountEmail: null,
                currentAccountPicture: Avatar(
                    animate: false, radius: 40, image: Settings.i.userAvatar),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor)),
          ),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text("All Stories"),
            onTap: () {
              _scaffoldKey?.currentState?.closeDrawer();
              context.go('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text("Your Profile"),
            onTap: () {
              _scaffoldKey?.currentState?.closeDrawer();
              context.go('/profile');
            },
          ),
          if (kDebugMode)
            ListTile(
              leading: Icon(Icons.paid),
              title: Text("Your Purchases"),
              onTap: () {
                _scaffoldKey?.currentState?.closeDrawer();
                context.go('/iap');
              },
            ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate this app"),
            onTap: () {
              InAppReview.instance.openStoreListing();
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Feedback"),
            onTap: () {
             
            },
          ),
          if (Settings.i.debugMode)
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text("Developer $tap"),
              onTap: () {
                _scaffoldKey?.currentState?.closeDrawer();
                context.go('/developer');
              },
            ),
          Spacer(),
          ListTile(
            title: Text(packageInfo?.version == null
                ? ''
                : "Ver: ${packageInfo?.version} ${packageInfo?.buildNumber}"),
            onTap: () {
              setState(() => tap++);
              if (tap > 10) {
                tap = 0;
                Settings.i.debugMode = !Settings.i.debugMode;
                Settings.save();
              }
            },
          ),
        ],
      ),
    );
  }

  PreferredSize makeAppBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 80),
      child: Builder(builder: (context) {
        return Container(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      color: Colors.white60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.leading ??
                              (Settings.i.showMenu
                                  ? IconButton(
                                      icon: const Icon(Icons.menu),
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer())
                                  : SizedBox(
                                      width: 10,
                                      height: 40,
                                    )),
                          if (widget.image != null)
                            Avatar(
                                animate: false,
                                radius: 20,
                                image: widget.image ?? ''),
                          Expanded(
                            child: AutoSizeText(widget.title,
                                maxLines: 1,
                                style: GoogleFonts.raleway(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300)),
                          )
                        ],
                      )),
                )));
      }),
    );
  }
}
