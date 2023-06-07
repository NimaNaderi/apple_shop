import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/config/theme/app_colors.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/data/model/variant_type_enum.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/utils/extensions/string_extensions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:apple_shop/widgets/project_appbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_state.dart';
import '../di/di.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
                      child: const ProjectAppBar(
                        appbarTitle: 'سبد خرید',
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
                    ),
                    if (state.basketSummary[0] != 0) ...{
                      SliverToBoxAdapter(
                        child: OrderSummary(basketSummary: state.basketSummary),
                      )
                    },
                    if (state.basketSummary[0] == 0) ...{
                      const SliverFillRemaining(
                        child: Text('سبد خرید شما خالی است'),
                      ),
                    },
                  ],
                  if (state is TransactionResponseState) ...[
                    if (state.isSuccess) ...{
                      const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Text('ممنون از خرید شما'),
                      )
                    },
                  ],
                  SliverPadding(padding: EdgeInsets.only(bottom: 100.h))
                ],
              ),
              if ((state is BasketDataFetchedState &&
                  state.basketSummary[0] != 0)) ...[
                Padding(
                  padding:
                      EdgeInsets.only(right: 44.w, left: 44.w, bottom: 20.h),
                  child: SizedBox(
                    height: 54.h,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        // context.read<BasketBloc>().add(BasketPaymentInitEvent());
                        context
                            .read<BasketBloc>()
                            .add(BasketPaymentRequestEvent());
                      },
                      child: !state.isPaymentLoading
                          ? Text(
                              'ادامه فرایند خرید',
                              textDirection: TextDirection.rtl,
                              style: theme.textTheme.labelLarge,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    'درحال ورود به درگاه پرداخت',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.labelLarge,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
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

class OrderSummary extends StatelessWidget {
  final List<int> basketSummary;

  const OrderSummary({super.key, required this.basketSummary});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 44.w, vertical: 22.h),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: CustomColors.green, width: 2),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 22,
              spreadRadius: -23,
              offset: Offset(12, 12),
            )
          ]),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'قیمت کالا های شما',
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontFamily: 'SM', color: theme.colorScheme.onSurface),
                ),
                const Spacer(),
                Text(
                  '${basketSummary[0].separateByComma()} تومان ',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onSurface),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text('سود شما از خرید ',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.error)),
                const Spacer(),
                Text(
                    '(%${(((basketSummary[0] - basketSummary[2]) / basketSummary[0]) * 100).round()})  ${basketSummary[1].separateByComma()} تومان ',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.error)),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Text('مبلغ قابل پرداخت',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontFamily: 'SM', color: theme.colorScheme.onSurface)),
                const Spacer(),
                Text('${basketSummary[2].separateByComma()} تومان ',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onSurface)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final BasketItem basketItem;

  const CartItem(
    this.basketItem, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
            height: 256.h,
            margin: EdgeInsets.only(left: 44.w, right: 44.w, bottom: 20.h),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 22,
                  spreadRadius: -23,
                  offset: Offset(12, 12),
                )
              ],
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
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.colorScheme.onSurface),
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              Text('گارانتی 18 ماه مدیا پردازش',
                                  style: theme.textTheme.labelSmall!.copyWith(
                                      color: AppColors.grey, fontFamily: 'SM')),
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
                                        '%${basketItem.percent!.round()}',
                                        style: theme.textTheme.labelSmall!
                                            .copyWith(fontFamily: 'SM'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    'تومان',
                                    style: theme.textTheme.labelSmall!.copyWith(
                                        fontFamily: 'SM',
                                        color: AppColors.grey),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    basketItem.price.separateByComma(),
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        color: AppColors.grey,
                                        fontFamily: 'SM'),
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
                                              Text('حذف',
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          color: theme
                                                              .colorScheme
                                                              .error,
                                                          fontFamily: 'SM')),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    QuantityChip(quantity: basketItem.quantity),
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
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontFamily: 'SM',
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        basketItem.discountPrice.separateByComma(),
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontFamily: 'SM',
                        ),
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
  final String? storageValue;
  final String title;

  const StorageChip(
    this.title, {
    this.storageValue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
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
              style: theme.textTheme.bodySmall!.copyWith(fontFamily: 'SM'),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              'گیگابایت',
              textDirection: TextDirection.rtl,
              style: theme.textTheme.bodySmall!.copyWith(fontFamily: 'SM'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  final String colorHexCode;
  final String colorName;

  const ColorChip(this.colorHexCode, this.colorName, {super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colorHexCode.parseToColor(),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        child: Text(
          colorName,
          style: theme.textTheme.bodySmall!
              .copyWith(color: Colors.white, fontFamily: 'SM'),
        ),
      ),
    );
  }
}

class QuantityChip extends StatelessWidget {
  final int quantity;

  const QuantityChip({Key? key, required this.quantity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
              'تعداد: ',
              style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.onSurface, fontFamily: 'SM'),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(quantity.toString(),
                style: theme.textTheme.bodySmall!
                    .copyWith(color: theme.colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}
