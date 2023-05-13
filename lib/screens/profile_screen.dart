import 'package:apple_shop/widgets/category_icon_item_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 44.w,
                right: 44.w,
                bottom: 32.h,
                top: 20.h,
              ),
              child: Container(
                height: 46.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.w,
                    ),
                    SvgPicture.asset('assets/icons/apple.svg',
                        color: CustomColors.blue, width: 24.w),
                    Expanded(
                      child: Text(
                        'حساب کاربری',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16.sp,
                          color: CustomColors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'نیما نادری',
              style: TextStyle(fontFamily: 'SB', fontSize: 16.sp),
            ),
            Text(
              '09102937012',
              style: TextStyle(fontFamily: 'SM', fontSize: 10.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: [
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                  // CategoryItemChip(),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'اپل شاپ',
              style: TextStyle(
                color: CustomColors.grey,
                fontSize: 10.sp,
                fontFamily: 'SM',
              ),
            ),
            Text(
              'v-1.0.00',
              style: TextStyle(
                color: CustomColors.grey,
                fontSize: 10.sp,
                fontFamily: 'SM',
              ),
            ),
            Text(
              'Instagram.com/nima_n_i',
              style: TextStyle(
                color: CustomColors.grey,
                fontSize: 10.sp,
                fontFamily: 'SM',
              ),
            )
          ],
        ),
      ),
    );
  }
}
