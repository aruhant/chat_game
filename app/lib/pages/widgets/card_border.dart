import 'package:flutter/material.dart';

class CardBorder extends StatelessWidget {
  const CardBorder(
      {Key? key,
      required this.child,
      this.elevated = true,
      this.colors,
      this.image,
      this.banner,
      this.bannerColor = Colors.transparent})
      : super(key: key);

  final String? banner;
  final Widget child;
  final AssetImage? image;
  final bool elevated;
  final List<Color>? colors;
  final Color bannerColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                image: image != null
                    ? DecorationImage(
                        image: image!,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop))
                    : null,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [0, 0.5, 1.0],
                  // colors: colors ?? [Colors.grey, Colors.white, Colors.white],
                  // colors:  colors ?? [Color(14864835), Color(16645371), Color(14864835)],
                  colors: colors ??
                      [Color(0xff999999), Color(0xffcccccc), Color(0xffffffff)],
                  // [Color(0xfffff1eb), Color(0xfface0f9), Color(0xfffff1eb)],
                  // [Color(3285181183), Color(4126669567), Color(3285181183)],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: elevated
                    ? [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 9,
                            blurRadius: 9,
                            offset: Offset(3, 3))
                      ]
                    : []),
            child: Center(child: child)),
        Positioned.fill(
            child: ClipRect(
          child: Banner(
              message: banner ?? '',
              location: BannerLocation.topStart,
              color: bannerColor,
              child: Container()),
        ))
      ],
    );
  }
}
