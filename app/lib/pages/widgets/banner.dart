import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BannerX extends StatelessWidget {
  const BannerX({super.key, required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Transform.translate(
          offset: Offset(-40, 20),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Container(
                height: 30,
                width: 150,
                color: color,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 34, right: 34),
                  child: AutoSizeText(label,
                      maxLines: 1,
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                ))),
          ),
        ));
  }
}
