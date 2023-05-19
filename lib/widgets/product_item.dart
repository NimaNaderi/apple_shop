import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  Product product;

  ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider<BasketBloc>.value(
            value: locator.get<BasketBloc>(),
            child: ProductDetailScreen(product),
          ),
        ));
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 216.h,
          width: 160.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 98,
                    child: CachedImage(
                      imageUrl: product.thumbnail,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 10.w,
                    child: SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: SvgPicture.asset('assets/icons/like-filled.svg'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 5.w,
                    child: Container(
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
                          '${product.percent!.round().toString()} %',
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w, bottom: 10.h),
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: TextStyle(fontFamily: 'SM', fontSize: 14.sp),
                    ),
                  ),
                  Container(
                    height: 53.h,
                    decoration: BoxDecoration(
                      color: CustomColors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 25,
                          spreadRadius: -12,
                          offset: Offset(0, 16),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
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
                            width: 5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.price.separateByComma(),
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12.sp,
                                  fontFamily: 'SM',
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                (product.price + product.discountPrice)
                                    .separateByComma(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontFamily: 'SM',
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 24.w,
                            child: SvgPicture.asset(
                                'assets/icons/arrow-right-filled.svg'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
