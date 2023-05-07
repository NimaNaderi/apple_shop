import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skeletons/skeletons.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  double radius;
  BoxFit fit;
  CachedImage(
      {super.key, this.imageUrl, this.radius = 0, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: fit,
        placeholder: (context, url) => SkeletonAvatar(),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
