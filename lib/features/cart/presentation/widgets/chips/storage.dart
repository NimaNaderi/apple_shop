import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/colors.dart';
class StorageChip extends StatelessWidget {
  final String? storageValue;
  final String title;

  const StorageChip(
      this.title, {
        this.storageValue,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              storageValue!,
              style: theme.textTheme.bodySmall!.copyWith(fontFamily: 'SM'),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              'گیگابایت',
              textDirection: TextDirection.rtl,
              style: theme.textTheme.bodySmall!.copyWith(fontFamily: 'SM'),
            ),
          ],
        ),
      ),
    );
  }
}
