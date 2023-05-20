import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingItems extends StatelessWidget {
  String title;
  LoadingItems({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        LoadingAnimationWidget.beat(
            color: theme.primaryColor, size: 32),
        const SizedBox(
          height: 16,
        ),
        Text(
          title,
          style: theme.textTheme.bodyMedium,
        )
      ],
    );
  }
}
