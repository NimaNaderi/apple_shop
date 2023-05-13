import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 340.w,
                  height: 340.h,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
