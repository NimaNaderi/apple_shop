import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome_pattern.png'),
          fit: BoxFit.contain,
          repeat: ImageRepeat.repeatY,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 44.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'اوج هیجان',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontFamily: 'SB',
                  ),
                ),
                Text(
                  'با خرید محصولات',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontFamily: 'SB',
                  ),
                ),
                Text(
                  '!اپل',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.sp,
                    fontFamily: 'SB',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              margin: EdgeInsets.only(right: 44.w),
              padding: const EdgeInsets.all(16),
              height: 70.h,
              width: 70.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff253DEE),
              ),
              child: SvgPicture.asset('assets/icons/arrow-welcome.svg'),
            ),
          ),
          const Spacer(),
          Center(
            child: Column(
              children: [
                Text(
                  'From',
                  style: TextStyle(
                      color: const Color(0xff86A5F8),
                      fontSize: 12.sp,
                      fontFamily: 'GB'),
                ),
                Text('Nima Naderi',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'GB')),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}