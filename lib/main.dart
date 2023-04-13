import 'package:apple_shop/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => const MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: BannerSlider(),
          ),
        ),
      ),
    );
  }
}
