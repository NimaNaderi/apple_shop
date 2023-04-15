import 'dart:ui';

import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                  right: 44.w,
                  bottom: 32.h,
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
                      Image.asset('assets/images/icon_apple_blue.png'),
                      Expanded(
                        child: Text(
                          'آیفون',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16.sp,
                            color: CustomColors.blue,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/icon_back.png'),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Text(
                  'Se آیفون 2022',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'SB',
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  width: 340.w,
                  height: 284.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, top: 10.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/icon_star.png'),
                              Text(
                                '4.6',
                                style: TextStyle(
                                    fontSize: 12.sp, fontFamily: 'SM'),
                              ),
                              Spacer(),
                              Expanded(
                                child: SizedBox(
                                  height: double.infinity,
                                  child: Image.asset(
                                    'assets/images/iphone.png',
                                  ),
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                  'assets/images/icon_favorite_deactive.png'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 70.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              height: 70.h,
                              width: 70.w,
                              margin: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: CustomColors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Image.asset('assets/images/iphone.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  right: 44.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'انتخاب رنگ',
                      style: TextStyle(fontFamily: 'SM', fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          height: 26.h,
                          width: 26.w,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          height: 26.h,
                          width: 26.w,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          height: 26.h,
                          width: 26.w,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  right: 44.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'انتخاب حافظه داخلی',
                      style: TextStyle(fontFamily: 'SM', fontSize: 12.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          height: 26.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(color: CustomColors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Center(
                              child: Text(
                                '512',
                                style: TextStyle(
                                    fontFamily: 'SB', fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          height: 26.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(color: CustomColors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Center(
                              child: Text(
                                '256',
                                style: TextStyle(
                                    fontFamily: 'SB', fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.w),
                          height: 26.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border:
                                Border.all(color: CustomColors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Center(
                              child: Text(
                                '128',
                                style: TextStyle(
                                    fontFamily: 'SB', fontSize: 12.sp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: 340.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: CustomColors.grey, width: 1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Image.asset('assets/images/icon_left_categroy.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'مشاهده',
                              style: TextStyle(
                                color: CustomColors.blue,
                                fontSize: 12.sp,
                                fontFamily: 'SB',
                              ),
                            ),
                            Spacer(),
                            Text(
                              ':مشخصات فنی',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SM',
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    width: 340.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: CustomColors.grey, width: 1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Image.asset('assets/images/icon_left_categroy.png'),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'مشاهده',
                            style: TextStyle(
                              color: CustomColors.blue,
                              fontSize: 12.sp,
                              fontFamily: 'SB',
                            ),
                          ),
                          Spacer(),
                          Text(
                            ':توضیحات محصول',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SM',
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      width: 340.w,
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: CustomColors.grey, width: 1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/icon_left_categroy.png'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'مشاهده',
                              style: TextStyle(
                                color: CustomColors.blue,
                                fontSize: 12.sp,
                                fontFamily: 'SB',
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      height: 26.h,
                                      width: 26.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15.w,
                                    child: Container(
                                      height: 26.h,
                                      width: 26.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30.w,
                                    child: Container(
                                      height: 26.h,
                                      width: 26.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45.w,
                                    child: Container(
                                      height: 26.h,
                                      width: 26.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60.w,
                                    child: Container(
                                      height: 26.h,
                                      width: 26.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.grey,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '+10',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                            fontFamily: 'SB',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              ':نظرات کاربران',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SM',
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 44.w),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceTagButton(),
                    AddToBasketButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  const AddToBasketButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: CustomColors.blue,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 160.w,
                height: 54.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    'افزودن به سبد خرید',
                    style: TextStyle(
                      fontFamily: 'SB',
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140.w,
          height: 66.h,
          decoration: BoxDecoration(
            color: CustomColors.green,
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 160.w,
                height: 54.h,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      Text(
                        'تومان',
                        style: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '۱۷٬۸۰۰٬۰۰۰',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'SM',
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '۱۶٬۹۸۹٬۰۰۰',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
