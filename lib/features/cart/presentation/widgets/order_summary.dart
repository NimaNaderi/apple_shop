import 'package:apple_shop/common/utils/extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constants/colors.dart';

class OrderSummary extends StatelessWidget {
  final List<int> basketSummary;

  const OrderSummary({super.key, required this.basketSummary});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 44.w, vertical: 22.h),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: CustomColors.green, width: 2),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 22,
              spreadRadius: -23,
              offset: Offset(12, 12),
            )
          ]),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'قیمت کالا های شما',
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontFamily: 'SM', color: theme.colorScheme.onSurface),
                ),
                const Spacer(),
                Text(
                  '${basketSummary[0].separateByComma()} تومان ',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text('سود شما از خرید ',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.error)),
                const Spacer(),
                Text(
                    '(%${(((basketSummary[0] - basketSummary[2]) / basketSummary[0]) * 100).round()})  ${basketSummary[1].separateByComma()} تومان ',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.error)),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text('مبلغ قابل پرداخت',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.onSurface)),
                const Spacer(),
                Text('${basketSummary[2].separateByComma()} تومان ',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onSurface)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
