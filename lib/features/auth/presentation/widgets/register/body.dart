import 'package:apple_shop/features/auth/presentation/screens/login_screen.dart';
import 'package:apple_shop/features/auth/presentation/widgets/register/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});

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
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: RegisterTextFields(),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
          child: const Text(
            'حساب دارید ؟ وارد شوید',
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
