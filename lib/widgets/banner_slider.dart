import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/product/product_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  List<BannerCampain> bannerList;
  List<Product> productList;

  BannerSlider(this.bannerList, this.productList, {super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final pageController = PageController(viewportFraction: .9);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: deviceSize.height * 0.23.h,
          // height: 177.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                for (var product in productList) {
                  if (product.id == bannerList[index].productId) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider<BasketBloc>.value(
                          value: locator.get<BasketBloc>(),
                          child: ProductDetailScreen(product)),
                    ));
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                child: CachedImage(
                  fit: BoxFit.cover,
                  imageUrl: bannerList[index].thumbnail,
                  radius: 16.r,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 4,
            effect: const ExpandingDotsEffect(
              expansionFactor: 4,
              dotHeight: 6,
              dotWidth: 6,
              dotColor: Colors.white,
              activeDotColor: CustomColors.blueIndicator,
            ),
          ),
        )
      ],
    );
  }
}
