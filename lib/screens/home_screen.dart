import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_icon_item_chip.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                          'جستجوی محصولات',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 16.sp,
                            color: CustomColors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset('assets/images/icon_search.png'),
                      SizedBox(
                        width: 16.w,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: BannerSlider(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                  right: 44.w,
                  bottom: 20.h,
                  top: 32.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'دسته بندی',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12.sp,
                        color: CustomColors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100.h,
                child: getProductCategoryList(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 44.w, right: 44.w, bottom: 20.h),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text(
                      'مشاهده همه',
                      style:
                          TextStyle(fontFamily: 'SB', color: CustomColors.blue),
                    ),
                    const Spacer(),
                    Text(
                      'پرفروش ترین ها',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12.sp,
                        color: CustomColors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 44.w),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const ProductDetailScreen())));
                        },
                        child: const ProductItem(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                  right: 44.w,
                  bottom: 20.h,
                  top: 32.h,
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/icon_left_categroy.png'),
                    SizedBox(
                      width: 10.w,
                    ),
                    const Text(
                      'مشاهده همه',
                      style:
                          TextStyle(fontFamily: 'SB', color: CustomColors.blue),
                    ),
                    const Spacer(),
                    Text(
                      'پربازدید ترین ها',
                      style: TextStyle(
                        fontFamily: 'SB',
                        fontSize: 12.sp,
                        color: CustomColors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(right: 44.w),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  const ProductDetailScreen())));
                        },
                        child: const ProductItem(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(bottom: 20.h))
          ],
        ),
      ),
    );
  }
}

Widget getProductCategoryList() {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: EdgeInsets.only(right: 44.w),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: CategoryItemChip(),
        ),
        scrollDirection: Axis.horizontal,
      ),
    ),
  );
}
