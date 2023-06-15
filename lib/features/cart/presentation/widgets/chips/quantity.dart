import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/constants/colors.dart';

class QuantityChip extends StatelessWidget {
  final int quantity;

  const QuantityChip({Key? key, required this.quantity}) : super(key: key);

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
              'تعداد: ',
              style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurface, fontFamily: 'SM'),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(quantity.toString(),
                style: theme.textTheme.bodySmall!
                    .copyWith(color: theme.colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
