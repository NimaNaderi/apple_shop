import 'package:apple_shop/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_fields.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icon_application.png',
                width: 100.w,
                height: 100.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'اپل شاپ',
                style: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 24.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 74.h),
            padding:  EdgeInsets.all(20.h),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
            child: LoginTextFields(),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterScreen(),
            ),
          ),
          child: const Text(
            'حساب ندارید ؟ ایجاد کنید',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
