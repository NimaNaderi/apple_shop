import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  List<BannerCampain> bannerList;
  BannerSlider(this.bannerList, {super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final pageController = PageController(viewportFraction: 0.9.w);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: deviceSize.width > 350 ? 160.h : 177.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: bannerList.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: CachedImage(
                fit: BoxFit.cover,
                imageUrl: bannerList[index].thumbnail,
                radius: 16.r,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10.h,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
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
