import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 56.h,
              width: 56.w,
              decoration: ShapeDecoration(
                color: Colors.red,
                shadows: const [
                  BoxShadow(
                    blurRadius: 25,
                    spreadRadius: -12,
                    offset: Offset(0, 16),
                    color: Colors.red,
                  )
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ),
            Icon(
              Icons.mouse,
              size: 32.h,
              color: Colors.white,
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'همه',
          style: TextStyle(fontFamily: 'SB', fontSize: 12.sp),
        ),
      ],
    );
  }
}
