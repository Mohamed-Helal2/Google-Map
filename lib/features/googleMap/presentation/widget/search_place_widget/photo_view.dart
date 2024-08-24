import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photoview extends StatelessWidget {
  final String imageUrl;
  const Photoview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PhotoView(
      imageProvider: CachedNetworkImageProvider(imageUrl),
    ));
  }
}
