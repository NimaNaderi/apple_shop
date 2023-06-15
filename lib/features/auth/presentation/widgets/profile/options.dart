import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_chip.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Wrap(
          runSpacing: 26.h,
          spacing: 36.w,
          children: List.generate(
            11,
            (index) => ProfileItemChip(
              title: index == 10 ? 'گیتهاب من' : 'گزینه ${index + 1}',
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}
