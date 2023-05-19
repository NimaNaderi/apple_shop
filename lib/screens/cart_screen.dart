import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/data/model/variant_type_enum.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/utils/extensions/string_extensions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_state.dart';
import '../data/model/product.dart';
import '../di/di.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // BlocProvider.of<BasketBloc>(context).add(BasketFetchFromHiveEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) => Stack(
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
                  if (state is BasketDataFetchedState) ...[
                    state.basketItemList.fold(
                      (l) => SliverToBoxAdapter(
                        child: Text(l),
                      ),
                      (basketItemList) => SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => CartItem(basketItemList[index]),
                            childCount: basketItemList.length),
                      ),
                    )
                  ],
                  SliverPadding(padding: EdgeInsets.only(bottom: 100.h))
                ],
              ),
              if (state is BasketDataFetchedState) ...[
                Padding(
                  padding:
                      EdgeInsets.only(right: 44.w, left: 44.w, bottom: 20.h),
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
                        state.finalBasketPrice == 0
                            ? 'سبد خرید شما خالی میباشد'
                            : '${state.finalBasketPrice.separateByComma()} تومان ',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'SB',
                        ),
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  BasketItem basketItem;

  CartItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state is HomeRequestSuccessState) {
              for (var product in state.productList) {
                if (basketItem.id == product.id) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<BasketBloc>.value(
                        value: locator.get<BasketBloc>(),
                        child: ProductDetailScreen(product)),
                  ));
                }
              }
            }
          },
          child: Container(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                basketItem.name,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'SB', fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text(
                                'گارانتی سلطان 18 ماهه',
                                style: TextStyle(
                                    fontFamily: 'SM', fontSize: 12.sp),
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
                                        '% ${basketItem.percent!.round()}',
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
                                    style: TextStyle(
                                        fontFamily: 'SM', fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    basketItem.price.separateByComma(),
                                    style: TextStyle(
                                        fontFamily: 'SM', fontSize: 12.sp),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.w,
                                  children: [
                                    for (var basketItemVariant in basketItem
                                        .basketItemVariantList) ...{
                                      if (basketItemVariant.variantType.type ==
                                          VariantTypeEnum.COLOR) ...{
                                        ColorChip(
                                            basketItemVariant.variant.value!,
                                            basketItemVariant.variant.name!)
                                      },
                                      if (basketItemVariant.variantType.type ==
                                          VariantTypeEnum.STORAGTE) ...{
                                        StorageChip('گیگابایت',
                                            storageValue:
                                                basketItemVariant.variant.value)
                                      },
                                    },
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<BasketBloc>()
                                            .add(BasketItemDeleted(basketItem));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: CustomColors.red,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 2.h),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              SvgPicture.asset(
                                                'assets/icons/trash.svg',
                                                height: 12,
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Text(
                                                'حذف',
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    fontFamily: 'SM',
                                                    fontSize: 12.sp,
                                                    color: CustomColors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 104.h,
                        // width: 100.w,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: CachedImage(imageUrl: basketItem.thumbnail),
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
                        basketItem.discountPrice.separateByComma(),
                        style: TextStyle(fontFamily: 'SB', fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StorageChip extends StatelessWidget {
  String? storageValue;
  String title;

  StorageChip(
    this.title, {
    this.storageValue,
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
            Text(
              storageValue!,
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 12.sp,
                color: CustomColors.grey,
              ),
            ),
            SizedBox(
              width: 4.w,
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

class ColorChip extends StatelessWidget {
  String colorHexCode;
  String colorName;

  ColorChip(this.colorHexCode, this.colorName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorHexCode.parseToColor(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        child: Text(
          colorName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'SM',
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
