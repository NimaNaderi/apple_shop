import 'package:apple_shop/features/auth/presentation/widgets/profile/body.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: ProfileBody(),
    );
  }
}
