import 'package:flutter/material.dart';

import '../../../../common/utils/utils.dart';
import '../../../../config/theme/app_colors.dart';

class TransactionDetail extends StatelessWidget {
  final String title;
  final String value;
  final int index;

  const TransactionDetail(
      {Key? key, required this.title, required this.value, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            decoration: index == 6
                ? BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: value == 'موفق'
                  ? AppColors.green.withOpacity(0.2)
                  : AppColors.red.withOpacity(0.2),
            )
                : null,
            padding: index == 6
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 4)
                : null,
            child: Text(
              value,
              textDirection: TextDirection.rtl,
              style: theme.textTheme.titleMedium!.copyWith(
                color: Utils.getTransactionValueColor(index, value),
              ),
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: theme.textTheme.titleMedium!.copyWith(
              color: Utils.getTransactionTitleColor(index),
            ),
          ),
        ],
      ),
    );
  }
}
