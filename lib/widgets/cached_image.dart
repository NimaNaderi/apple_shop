import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  double radius;
  CachedImage({super.key, this.imageUrl, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey,
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
