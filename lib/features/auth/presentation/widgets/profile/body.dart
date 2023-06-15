import 'package:apple_shop/features/auth/presentation/widgets/profile/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/widgets/project_appbar.dart';
import '../../../../../config/theme/app_colors.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 44.w,
              right: 44.w,
              bottom: 32.h,
              top: 20.h,
            ),
            child: const ProjectAppBar(appbarTitle: 'حساب کاربری'),
          ),
          Text(
            'نیما نادری',
            style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onBackground),
          ),
          Text(
            '09102937012',
            style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
          ),
          SizedBox(
            height: 30.h,
          ),
          const ProfileOptions(),
          const Spacer(),
          Text(
            'اپل شاپ',
            style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
          ),
          Text(
            'v-2.0.00',
            style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
          ),
          Text(
            'instagram.com/nima_n_i',
            style: theme.textTheme.labelSmall!.copyWith(color: AppColors.grey,fontFamily: 'SM'),
          ),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    );
  }
}
