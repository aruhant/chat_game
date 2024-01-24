import 'package:flutter/material.dart';
import 'package:chat-game/models/settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:io';

class Avatar extends StatelessWidget {
  const Avatar(
      {super.key, this.animate = false, this.radius = 40, required this.image});

  final String image;
  final bool animate;
  final double radius;
  @override
  Widget build(BuildContext context) {
    String assetImage = image.replaceAll('_USERAVATAR_', Settings.i.userAvatar);
    return AvatarGlow(
      glowColor: Theme.of(context).primaryColor,
      endRadius: radius * 1.6,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 2000),
      shape: BoxShape.circle,
      animate: animate,
      curve: Curves.fastOutSlowIn,
      child: Material(
        elevation: 8.0,
        shape: CircleBorder(
            side: BorderSide(
                color: Theme.of(context).primaryColor, width: radius / 40)),
        color: Colors.transparent,
        child: CircleAvatar(
            backgroundImage: assetImage.contains('/')
                ? Image.file(File(assetImage)).image
                : AssetImage('assets/images/$assetImage.jpg'),
            radius: radius),
      ),
    );
  }
}
