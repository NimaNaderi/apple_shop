import 'package:apple_shop/common/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorChip extends StatelessWidget {
  final String colorHexCode;
  final String colorName;

  const ColorChip(this.colorHexCode, this.colorName, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colorHexCode.parseToColor(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        child: Text(
          colorName,
          style: theme.textTheme.bodySmall!
              .copyWith(color: Colors.white, fontFamily: 'SM'),
        ),
      ),
    );
  }
}
