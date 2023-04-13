import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(viewportFraction: 0.8.w);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Container(
                color: Colors.red,
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
              dotHeight: 10,
              dotWidth: 10,
              dotColor: Colors.white,
              activeDotColor: CustomColors.blueIndicator,
            ),
          ),
        )
      ],
    );
  }
}
