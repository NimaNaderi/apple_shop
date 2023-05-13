import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/utils/extensions/string_extensions.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 44.w,
                      right: 44.w,
                      bottom: 32.h,
                      top: 20.h,
                    ),
                    child: Container(
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16.w,
                          ),
                          SvgPicture.asset('assets/icons/apple.svg',
                              color: CustomColors.blue, width: 24.w),
                          Expanded(
                            child: Text(
                              'سبد خرید',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 16.sp,
                                color: CustomColors.blue,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => CartItem(),
                      childCount: 10),
                ),
                SliverPadding(padding: EdgeInsets.only(bottom: 100.h))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 44.w, left: 44.w, bottom: 20.h),
              child: SizedBox(
                height: 54.h,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'ادامه فرایند خرید',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'SB',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      margin: EdgeInsets.only(left: 44.w, right: 44.w, bottom: 20.h),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'آیفون 13 پرومکس',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontFamily: 'SB', fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          'گارانتی سلطان 18 ماهه',
                          style: TextStyle(fontFamily: 'SM', fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: CustomColors.red,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  '%۳',
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              'تومان',
                              style:
                                  TextStyle(fontFamily: 'SM', fontSize: 12.sp),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              '۴۸.۸۰۰.۰۰۰',
                              style:
                                  TextStyle(fontFamily: 'SM', fontSize: 12.sp),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Wrap(
                          spacing: 8.w,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: CustomColors.red,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 2.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      'حذف',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'SM',
                                          fontSize: 12.sp,
                                          color: CustomColors.red),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    SvgPicture.asset('assets/icons/trash.svg'),
                                  ],
                                ),
                              ),
                            ),
                            OptionChip(
                              'آبی',
                              color: '4287f5',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 104.h,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Image.asset('assets/images/iphone.png'),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: DottedLine(
              lineThickness: 3,
              dashLength: 8,
              dashColor: CustomColors.grey.withOpacity(0.5),
              dashGapLength: 3,
              dashGapColor: Colors.transparent,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تومان',
                  style: TextStyle(fontFamily: 'SB', fontSize: 16.sp),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Text(
                  '59.000.000',
                  style: TextStyle(fontFamily: 'SB', fontSize: 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  String? color;
  String title;

  OptionChip(
    this.title, {
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...{
              Container(
                height: 12.h,
                width: 12.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.parseToColor()),
              )
            },
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'SM', fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

