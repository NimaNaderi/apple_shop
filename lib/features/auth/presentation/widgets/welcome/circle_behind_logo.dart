import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleBehindLogo extends StatelessWidget {
  final double horizontalMargin;
  const CircleBehindLogo({
    super.key,
    required this.horizontalMargin,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }
}