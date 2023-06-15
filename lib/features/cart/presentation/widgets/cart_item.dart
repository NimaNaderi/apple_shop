import 'package:apple_shop/common/utils/extensions/int_extensions.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../../bloc/home/home_state.dart';
import '../../../../common/constants/colors.dart';
import '../../../../common/widgets/cached_image.dart';
import '../../../../config/di/di.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../data/model/basket_item.dart';
import '../../../../data/model/variant_type_enum.dart';
import '../../../../screens/product_detail_screen.dart';
import '../bloc/basket_bloc.dart';
import '../bloc/basket_event.dart';
import 'chips/color.dart';
import 'chips/quantity.dart';
import 'chips/storage.dart';
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
