import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'apple_shop_logo.dart';
import 'bottom_text.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff58AEE8),
            Color(0xff3B5EDF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          const Expanded(child: AppleShopLogo()),
          const Expanded(
            child: BottomText(),
          ),
        ],
      ),
    );
  }
}
