import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String url;

  const ImageViewer({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photoViewController = PhotoViewController();
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
              child: Container(color: Colors.black),
              onTapUp: (details) => context.pop(),
            )),
            Center(
              child: PhotoView(
                  tightMode: true,
                  backgroundDecoration: BoxDecoration(color: Colors.black),
                  heroAttributes: PhotoViewHeroAttributes(
                      tag: url, transitionOnUserGestures: true),
                  controller: photoViewController,
                  minScale: 0.5,
                  maxScale: 2.0,
                  imageProvider: AssetImage(url)),
            ),
            Positioned(
                top: 20,
                right: 20,
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () => context.pop(),
                  color: Colors.black12,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    size: 16,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: CircleBorder(),
                ))
          ],
        ),
      ),
    );
  }
}
