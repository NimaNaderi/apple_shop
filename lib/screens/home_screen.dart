import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/bloc/home/home_state.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_icon_item_chip.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is HomeLoadingState) ...[
                  SliverToBoxAdapter(child: CircularProgressIndicator()),
                ],
                _getSearchBox(),
                if (state is HomeRequestSuccessState) ...[
                  state.bannerList.fold((exceptionMessage) {
                    return SliverToBoxAdapter(
                      child: Text(exceptionMessage),
                    );
                  }, (bannerList) {
                    return _getBanners(bannerList);
                  })
                ],
                _getCategoryListTitle(),
                _getCategoryList(),
                _getBestSellerTitle(),
                _getBestSellerProducts(),
                _getMostViewedTitle(),
                _getMostViewedProducts(),
                SliverPadding(padding: EdgeInsets.only(bottom: 20.h))
              ],
            );
          },
        ),
      ),
    );
  }
}

class _getMostViewedProducts extends StatelessWidget {
  const _getMostViewedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                      builder: ((context) => const ProductDetailScreen())));
                },
                child: const ProductItem(),
              ),
            ),
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
    return SliverToBoxAdapter(
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
              style: TextStyle(fontFamily: 'SB', color: CustomColors.blue),
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
    );
  }
}

class _getBestSellerProducts extends StatelessWidget {
  const _getBestSellerProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
                      builder: ((context) => const ProductDetailScreen())));
                },
                child: const ProductItem(),
              ),
            ),
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
    return SliverToBoxAdapter(
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
              style: TextStyle(fontFamily: 'SB', color: CustomColors.blue),
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
    );
  }
}

class _getCategoryList extends StatelessWidget {
  const _getCategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100.h,
        child: getProductCategoryList(),
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
    return SliverToBoxAdapter(
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
    );
  }
}

class _getBanners extends StatelessWidget {
  List<BannerCampain> bannerList;
  _getBanners(
    this.bannerList, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BannerSlider(bannerList),
    );
  }
}

class _getSearchBox extends StatelessWidget {
  const _getSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
