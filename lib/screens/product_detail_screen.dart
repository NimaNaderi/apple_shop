import 'dart:ui';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/data/model/basket_item_variant.dart';
import 'package:apple_shop/data/model/property.dart';
import 'package:apple_shop/utils/extensions/int_extensions.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../data/model/product.dart';
import '../data/model/product_image.dart';
import '../data/model/product_variant.dart';
import '../data/model/variant.dart';
import '../data/model/variant_type.dart';
import '../data/model/variant_type_enum.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;

  ProductDetailScreen(this.product, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          var bloc = ProductBloc();
          bloc.add(ProductInitializeEvent(
              widget.product.id, widget.product.categoryId));
          return bloc;
        },
        child: DetailContent(parentWidget: widget));
  }
}

class DetailContent extends StatelessWidget {
  DetailContent({
    super.key,
    required this.parentWidget,
  });

  final ProductDetailScreen parentWidget;
  List<BasketItemVariant> basketItemVariantList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                if (state is ProductDetailLoadingState) ...{
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        LoadingAnimationWidget.beat(
                            color: CustomColors.blue, size: 32),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'درحال دریافت اطلاعات محصول',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SB',
                              color: CustomColors.grey),
                        )
                      ],
                    ),
                  ),
                } else ...{
                  if (state is ProductDetailResponseState) ...{
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 44.w,
                          right: 44.w,
                          bottom: 32.h,
                          top: 12.h,
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
                                  child: state.productCategory.fold(
                                (exceptionMessage) => Text(
                                  'اطلاعات محصول',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16.sp,
                                    color: CustomColors.blue,
                                  ),
                                ),
                                (productCategory) => Text(
                                  productCategory.title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SB',
                                    fontSize: 16.sp,
                                    color: CustomColors.blue,
                                  ),
                                ),
                              )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/arrow-right.svg',
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  },
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Text(
                        parentWidget.product.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: 'SB',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  if (state is ProductDetailResponseState) ...{
                    state.productImages.fold((l) {
                      return const SliverToBoxAdapter(
                        child: Text('خطا'),
                      );
                    }, (productImageList) {
                      return GalleryWidget(
                          productImageList, parentWidget.product.thumbnail);
                    })
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productVariants.fold((l) {
                      return const SliverToBoxAdapter(
                        child: Text('خطا'),
                      );
                    }, (productVariantList) {
                      return VariantContainerGenerator(
                          productVariantList, basketItemVariantList);
                    })
                  },
                  if (state is ProductDetailResponseState) ...{
                    state.productProperties.fold((l) {
                      return ProductProperties([]);
                    },
                        (productPropertyList) =>
                            ProductProperties(productPropertyList))
                  },
                  ProductDescription(parentWidget.product.description),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 44.w),
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: CustomColors.grey, width: 1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/arrow-left.svg'),
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
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 44.w),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PriceTagButton(parentWidget.product),
                          AddToBasketButton(
                              parentWidget.product, basketItemVariantList),
                        ],
                      ),
                    ),
                  )
                }
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProductProperties extends StatefulWidget {
  List<Property> propertyList;

  ProductProperties(
    this.propertyList, {
    super.key,
  });

  @override
  State<ProductProperties> createState() => _ProductPropertiesState();
}

class _ProductPropertiesState extends State<ProductProperties> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 44.w),
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
                      SvgPicture.asset('assets/icons/arrow-left.svg'),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        _isVisible ? 'بستن' : 'مشاهده',
                        style: TextStyle(
                          color: CustomColors.blue,
                          fontSize: 12.sp,
                          fontFamily: 'SB',
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ':مشخصات فنی',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SM',
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                margin: EdgeInsets.only(left: 44.w, right: 44.w, top: 24.h),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustomColors.grey, width: 1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: widget.propertyList.isEmpty
                    ? Text(
                        '! مشخصاتی برای این محصول یافت نشد',
                        style: TextStyle(fontSize: 14.sp, fontFamily: 'SM'),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.propertyList.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                '${widget.propertyList[index].value} : ${widget.propertyList[index].title}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'SM',
                                    fontSize: 14.sp,
                                    height: 2),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDescription extends StatefulWidget {
  String productDescription;

  ProductDescription(
    this.productDescription, {
    super.key,
  });

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 44.w),
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
                    SvgPicture.asset('assets/icons/arrow-left.svg'),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      _isVisible ? 'بستن' : 'مشاهده',
                      style: TextStyle(
                        color: CustomColors.blue,
                        fontSize: 12.sp,
                        fontFamily: 'SB',
                      ),
                    ),
                    const Spacer(),
                    Text(
                      ':توضیحات محصول',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SM',
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: EdgeInsets.only(left: 44.w, right: 44.w, top: 24.h),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: CustomColors.grey, width: 1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                widget.productDescription.isNotEmpty
                    ? widget.productDescription
                    : '! توضیحاتی برای این محصول یافت نشد',
                textAlign: TextAlign.right,
                style:
                    TextStyle(fontFamily: 'SM', fontSize: 16.sp, height: 2.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  List<ProductVariant> productVariantList;
  List<BasketItemVariant> basketItemVariantList;

  VariantContainerGenerator(
    this.productVariantList,
    this.basketItemVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantChildGenerator(productVariant, basketItemVariantList)
            }
          }
        ],
      ),
    );
  }
}

class VariantChildGenerator extends StatelessWidget {
  ProductVariant productVariant;
  List<BasketItemVariant> basketItemVariantList;

  VariantChildGenerator(
    this.productVariant,
    this.basketItemVariantList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        right: 44.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            productVariant.variantType.title!,
            style: TextStyle(fontFamily: 'SM', fontSize: 12.sp),
          ),
          SizedBox(
            height: 10.h,
          ),
          if (productVariant.variantType.type == VariantTypeEnum.COLOR) ...{
            ColorVariantList(productVariant.variantList,
                productVariant.variantType, basketItemVariantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.STORAGTE) ...{
            StorageVariantList(productVariant.variantList,
                productVariant.variantType, basketItemVariantList)
          },
          if (productVariant.variantType.type == VariantTypeEnum.VOLTAGE) ...{
            StorageVariantList(productVariant.variantList,
                productVariant.variantType, basketItemVariantList)
          }
        ],
      ),
    );
  }
}

class AddToBasketButton extends StatelessWidget {
  Product product;
  List<BasketItemVariant> basketItemVariantList;

  AddToBasketButton(
    this.product,
    this.basketItemVariantList, {
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
              child: GestureDetector(
                onTap: () {
                  product.basketItemVariantList = basketItemVariantList;

                  context
                      .read<ProductBloc>()
                      .add(ProductAddedToBasket(product));

                  context.read<BasketBloc>().add(BasketFetchFromHiveEvent());
                  AnimatedSnackBar(
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    duration: const Duration(seconds: 5),
                    builder: ((context) {
                      return Container(
                        decoration: BoxDecoration(
                            color: CustomColors.green,
                            borderRadius: BorderRadius.circular(20.r)),
                        height: 50.h,
                        child: Center(
                          child: Text(
                            'محصول با موفقیت به سبد خرید افزوده شد.',
                            style: TextStyle(
                              fontFamily: 'SB',
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ).show(context);
                },
                child: Container(
                  width: 160.w,
                  height: 58.h,
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
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  Product product;

  PriceTagButton(
    this.product, {
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
                height: 58.h,
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
                            product.price.separateByComma(),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'SM',
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            (product.price + product.discountPrice)
                                .separateByComma(),
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
                            '% ${product.percent!.round()}',
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

class GalleryWidget extends StatefulWidget {
  List<ProductImage> productImageList;
  String? defaultProductThumbnail;
  int selectedItem = 0;

  GalleryWidget(this.productImageList, this.defaultProductThumbnail, {Key? key})
      : super(key: key);

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 10.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/star.svg'),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            '4.6',
                            style: TextStyle(fontSize: 12.sp, fontFamily: 'SM'),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SizedBox(
                          height: double.infinity,
                          width: 200.w,
                          child: widget.productImageList.isEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CachedImage(
                                        imageUrl:
                                            widget.defaultProductThumbnail),
                                  ],
                                )
                              : CachedImage(
                                  imageUrl: widget
                                      .productImageList[widget.selectedItem]
                                      .imageUrl),
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/icons/like.svg'),
                    ],
                  ),
                ),
              ),
              if (widget.productImageList.isNotEmpty) ...{
                SizedBox(
                  height: 70.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: ListView.builder(
                      itemCount: widget.productImageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.selectedItem = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 70.h,
                          width: 70.w,
                          margin: EdgeInsets.only(left: 20.w),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: widget.selectedItem == index
                                ? Border.all(
                                    width: 2,
                                    color: CustomColors.blue,
                                  )
                                : Border.all(
                                    width: 1,
                                    color: CustomColors.grey,
                                  ),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: CachedImage(
                            imageUrl: widget.productImageList[index].imageUrl,
                            radius: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              },
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorVariantList extends StatefulWidget {
  List<Variant> variantList;
  VariantType variantType;
  List<BasketItemVariant> basketItemVariantList;

  ColorVariantList(
      this.variantList, this.variantType, this.basketItemVariantList,
      {Key? key})
      : super(key: key);

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  BasketItemVariant? basketItemColorVariant;

  @override
  void initState() {
    basketItemColorVariant = BasketItemVariant(
        widget.variantType, widget.variantList[_selectedIndex]);

    widget.basketItemVariantList.add(basketItemColorVariant!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          itemCount: widget.variantList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                basketItemColorVariant!.variant = widget.variantList[index];
                if (widget.basketItemVariantList.any((element) =>
                    element.variantType.type == VariantTypeEnum.COLOR)) {
                  widget.basketItemVariantList.removeWhere((element) =>
                      element.variantType.type == VariantTypeEnum.COLOR);
                  widget.basketItemVariantList.add(basketItemColorVariant!);
                } else {
                  widget.basketItemVariantList.add(basketItemColorVariant!);
                }

                for (var item in widget.basketItemVariantList) {
                  print(
                      'Type Is ${item.variantType.name} , Value Is ${item.variant.name}');
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(left: 10.w),
              height: 26,
              width: _selectedIndex == index ? 66 : 26,
              decoration: BoxDecoration(
                color:
                    Color(int.parse('0xff${widget.variantList[index].value}')),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Visibility(
                visible: _selectedIndex == index,
                child: Center(
                  child: Text(
                    widget.variantList[index].name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'SM',
                      fontSize: 12.sp,
                    ),
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

class StorageVariantList extends StatefulWidget {
  List<Variant> storageVariants;
  VariantType variantType;
  List<BasketItemVariant> basketItemVariantList;

  StorageVariantList(
      this.storageVariants, this.variantType, this.basketItemVariantList,
      {Key? key})
      : super(key: key);

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  BasketItemVariant? basketItemStorageVariant;

  @override
  void initState() {
    basketItemStorageVariant = BasketItemVariant(
        widget.variantType, widget.storageVariants[_selectedIndex]);
    widget.basketItemVariantList.add(basketItemStorageVariant!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 26,
        child: ListView.builder(
          itemCount: widget.storageVariants.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                basketItemStorageVariant!.variant =
                    widget.storageVariants[index];

                if (widget.basketItemVariantList.any((element) =>
                    element.variantType.type == VariantTypeEnum.STORAGTE)) {
                  widget.basketItemVariantList.removeWhere((element) =>
                      element.variantType.type == VariantTypeEnum.STORAGTE);
                  widget.basketItemVariantList.add(basketItemStorageVariant!);
                } else {
                  widget.basketItemVariantList.add(basketItemStorageVariant!);
                }

                for (var item in widget.basketItemVariantList) {
                  print(
                      'Type Is ${item.variantType.name} , Value Is ${item.variant.name}');
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(left: 10.w),
              height: 26.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: _selectedIndex == index
                    ? Border.all(color: CustomColors.blueIndicator, width: 2)
                    : Border.all(color: CustomColors.grey, width: 1),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Text(
                    widget.storageVariants[index].value!,
                    style: TextStyle(fontFamily: 'SB', fontSize: 12.sp),
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
