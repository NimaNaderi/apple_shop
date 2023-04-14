import 'package:apple_shop/constants/colors.dart';
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
      builder: (context, child) => MaterialApp(
        home: Scaffold(
          backgroundColor: CustomColors.backgroundScreenColor,
          body: SafeArea(
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 44.w),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: CategoryHorizontalItemList(),
                    ),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryHorizontalItemList extends StatelessWidget {
  const CategoryHorizontalItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 56.h,
              width: 56.w,
              decoration: ShapeDecoration(
                color: Colors.red,
                shadows: const [
                  BoxShadow(
                    blurRadius: 25,
                    spreadRadius: -12,
                    offset: Offset(0, 16),
                    color: Colors.red,
                  )
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ),
            Icon(
              Icons.mouse,
              size: 32.h,
              color: Colors.white,
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          'همه',
          style: TextStyle(fontFamily: 'SB', fontSize: 12.sp),
        ),
      ],
    );
  }
}
