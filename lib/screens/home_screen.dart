import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/config/theme/app_colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/common/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../common/widgets/product_item.dart';
import '../data/model/product.dart';
import '../common/widgets/banner_slider.dart';
import '../common/widgets/category_icon_item_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const SearchBox(),
                if (state is HomeLoadingState) ...{
                  const SliverFillRemaining(
                    child: LoadingItems(title: 'درحال دریافت محصولات'),
                  ),
                } else ...{
                  if (state is HomeSearchRequestSuccessState) ...{
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.productList.length,
                          (context, index) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: ProductItem(state.productList[index]),
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1.9 / 2.6,
                        ),
                      ),
                    )
                  },
                  if (state is HomeRequestSuccessState) ...[
                    state.bannerList.fold((exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    }, (bannerList) {
                      return BannersSection(state.productList, bannerList);
                    })
                  ],

                  if (state is HomeRequestSuccessState) ...[
                    const CategoryListTitle(),
                    state.categoryList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (categoryList) {
                      return CategoryList(categoryList);
                    })
                  ],

                  if (state is HomeRequestSuccessState) ...[
                    const BestSellerTitle(),
                    state.bestSellerProductList.fold((exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    }, (productList) {
                      return BestSellerProducts(productList);
                    })
                  ],
                  if (state is HomeRequestSuccessState) ...[
                    const MostViewedTitle(),
                    state.hottestProductList.fold(
                      (exceptionMessage) => SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      ),
                      (mostViewedProductList) =>
                          MostViewedProducts(mostViewedProductList),
                    )
                  ],
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

class MostViewedProducts extends StatelessWidget {
  final List<Product> productList;

  const MostViewedProducts(
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

class MostViewedTitle extends StatelessWidget {
  const MostViewedTitle({
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

class BestSellerProducts extends StatelessWidget {
  final List<Product> productList;

  const BestSellerProducts(
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

class BestSellerTitle extends StatelessWidget {
  const BestSellerTitle({
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

class CategoryList extends StatelessWidget {
  final List<Category> categoryList;

  const CategoryList(
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

class CategoryListTitle extends StatelessWidget {
  const CategoryListTitle({
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
              style:
                  theme.textTheme.titleSmall!.copyWith(color: AppColors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class BannersSection extends StatelessWidget {
  final List<BannerCampain> bannerList;
  final List<Product> productList;

  const BannersSection(
    this.productList,
    this.bannerList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerList, productList),
    );
  }
}

class SearchBox extends StatefulWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    textFieldFocusNode.addListener(focusNodeListener);
  }

  focusNodeListener() => setState(() {});

  @override
  void dispose() {
    textFieldFocusNode.removeListener(focusNodeListener);
    super.dispose();
  }

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
        child: AnimatedContainer(
          height: 46.h,
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: textFieldFocusNode.hasFocus ? Border.all(color: AppColors.primaryColor,width: 2) : null
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
                child: TextField(
                  focusNode: textFieldFocusNode,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      context.read<HomeBloc>().add(HomeProductSearched(value));
                    } else {
                      context.read<HomeBloc>().add(HomeGetInitializeData());
                    }
                  },
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: textFieldFocusNode.hasFocus ? -12.h : -8.h),
                    hintText: 'جستجوی محصولات',
                    hintStyle: theme.textTheme.bodyLarge,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
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
