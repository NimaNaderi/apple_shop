import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/config/theme/app_colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constants/colors.dart';
import '../data/model/product.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_icon_item_chip.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey? imageKey;
  List<Product>? allProducts;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                // SliverToBoxAdapter(
                //   child: ElevatedButton(
                //     child: Text('Capture'),
                //     onPressed: () async {
                //       await DavinciCapture.click(imageKey!,
                //           saveToDevice: true,
                //           pixelRatio: 10,
                //           openFilePreview: true,
                //           fileName: 'TEETTEEE');
                //     },
                //   ),
                // ),
                if (state is HomeLoadingState) ...{
                  SliverFillRemaining(
                    child: LoadingItems(title: 'درحال دریافت محصولات'),
                  ),
                } else ...{
                  const _getSearchBox(),
                  if (state is HomeRequestSuccessState) ...[
                    state.bannerList.fold((exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    }, (bannerList) {
                      return _getBanners(state.productList,bannerList);
                    })
                  ],
                  const _getCategoryListTitle(),
                  if (state is HomeRequestSuccessState) ...[
                    state.categoryList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (categoryList) {
                      return _getCategoryList(categoryList);
                    })
                  ],

                  const _getBestSellerTitle(),
                  if (state is HomeRequestSuccessState) ...{
                    state.bestSellerProductList.fold((exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    }, (productList) {
                      return _getBestSellerProducts(productList);
                    })
                  },
                  const _getMostViewedTitle(),
                  if (state is HomeRequestSuccessState) ...[
                    state.hottestProductList.fold(
                      (exceptionMessage) => SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      ),
                      (mostViewedProductList) =>
                          _getMostViewedProducts(mostViewedProductList),
                    )
                  ],
                  // SliverToBoxAdapter(
                  //   child: Davinci(
                  //     builder: (key) {
                  //       imageKey = key;
                  //       return _getMostViewedProducts();
                  //     },
                  //   ),
                  // ),
                  SliverPadding(padding: EdgeInsets.only(bottom: 20.h))
                }
              ],
            );
          },
        ),
      ),
    );
  }
}

class _getMostViewedProducts extends StatelessWidget {
  List<Product> productList;

  _getMostViewedProducts(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: productList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
                left: index == productList.length - 1 ? 32.w : 20.w,
                right: index == 0 ? 32.w : 0),
            child: ProductItem(productList[index]),
          ),
        ),
      ),
    );
  }
}

class _getMostViewedTitle extends StatelessWidget {
  const _getMostViewedTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: 32.w,
          right: 32.w,
          bottom: 20.h,
          top: 32.h,
        ),
        child: Row(
          children: [
            Text(
              'پربازدید ترین ها',
              style: theme.textTheme.titleSmall,
            ),
            const Spacer(),
             Text(
              'مشاهده همه',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(
              width: 10.w,
            ),
            SvgPicture.asset('assets/icons/arrow-left.svg'),
          ],
        ),
      ),
    );
  }
}

class _getBestSellerProducts extends StatelessWidget {
  List<Product> productList;

  _getBestSellerProducts(
    this.productList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: productList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
                left: index == productList.length - 1 ? 32.w : 20.w,
                right: index == 0 ? 32.w : 0),
            child: ProductItem(productList[index]),
          ),
        ),
      ),
    );
  }
}

class _getBestSellerTitle extends StatelessWidget {
  const _getBestSellerTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsets.only(left: 32.w, right: 32.w, bottom: 20.h, top: 28.h),
        child: Row(
          children: [
            Text(
              'پرفروش ترین ها',
              style: theme.textTheme.titleSmall,
            ),
            const Spacer(),
             Text(
              'مشاهده همه',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(
              width: 10.w,
            ),
            SvgPicture.asset('assets/icons/arrow-left.svg'),
          ],
        ),
      ),
    );
  }
}

class _getCategoryList extends StatelessWidget {
  List<Category> categoryList;

  _getCategoryList(
    this.categoryList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100.h,
        child: getProductCategoryList(categoryList),
      ),
    );
  }
}

class _getCategoryListTitle extends StatelessWidget {

  const _getCategoryListTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          right: 32.w,
          bottom: 20.h,
          top: 32.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'دسته بندی',
              style: theme.textTheme.titleSmall!.copyWith(color: AppColors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class _getBanners extends StatelessWidget {
  List<BannerCampain> bannerList;
  List<Product> productList;

  _getBanners(this.productList,
    this.bannerList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerList,productList),
    );
  }
}

class _getSearchBox extends StatelessWidget {
  const _getSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          left: 32.w,
          right: 32.w,
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
              SvgPicture.asset('assets/icons/search.svg'),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  'جستجوی محصولات',
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              SvgPicture.asset('assets/icons/apple.svg',
                  color: theme.primaryColor, width: 24.w),
              SizedBox(
                width: 16.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget getProductCategoryList(List<Category> categoryList) {
  return ListView.builder(
    itemCount: categoryList.length,
    itemBuilder: (context, index) => Padding(
      padding: EdgeInsets.only(
          left: index == categoryList.length - 1 ? 32.w : 20.w,
          right: index == 0 ? 32.w : 0),
      child: CategoryItemChip(categoryList[index]),
    ),
    scrollDirection: Axis.horizontal,
  );
}
