import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItemChip extends StatelessWidget {
  String title;
  int index;

  ProfileItemChip({Key? key, required this.title,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Container(
          height: 56.h,
          width: 56.h,
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: theme.colorScheme.primary,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40.r),
            ),
          ),
          child: SvgPicture.asset(
            'assets/images/profile/$index.svg',
            color: theme.colorScheme.onPrimary,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          title,
          style: theme.textTheme.bodySmall!.copyWith(color: Colors.black),
        )
      ],
    );
  }
}
