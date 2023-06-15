import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'circle_behind_logo.dart';

class AppleShopLogo extends StatelessWidget {
  const AppleShopLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        const CircleBehindLogo(horizontalMargin: 44),
        const CircleBehindLogo(horizontalMargin: 72),
        const CircleBehindLogo(horizontalMargin: 100),
        const CircleBehindLogo(horizontalMargin: 130),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 130.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                height: 100.h,
                width: 84.w,
              ),
              SizedBox(height: 16.h),
              Text(
                'اپل شاپ',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SB',
                  fontSize: 20.sp,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
