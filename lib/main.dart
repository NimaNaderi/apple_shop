import 'dart:ui';

import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/screens/cart_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/product_detail_screen.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: IndexedStack(
            index: selectedBottomNavigationIndex,
            children: getLayout(),
          ),
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: selectedBottomNavigationIndex,
                onTap: (value) {
                  setState(() {
                    selectedBottomNavigationIndex = value;
                  });
                },
                selectedLabelStyle: TextStyle(
                    fontFamily: 'SB',
                    fontSize: 10.sp,
                    color: CustomColors.blue),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'SB',
                  fontSize: 10.sp,
                  color: Colors.black,
                ),
                items: [
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Image.asset('assets/images/icon_profile.png'),
                      ),
                      activeIcon: Container(
                        padding: EdgeInsets.only(bottom: 4.h),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 12),
                          )
                        ]),
                        child: Image.asset(
                            'assets/images/icon_profile_active.png'),
                      ),
                      label: 'حساب کاربری'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Image.asset('assets/images/icon_basket.png'),
                      ),
                      activeIcon: Container(
                        padding: EdgeInsets.only(bottom: 4.h),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 12),
                          )
                        ]),
                        child:
                            Image.asset('assets/images/icon_basket_active.png'),
                      ),
                      label: 'سبد خرید'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Image.asset('assets/images/icon_category.png'),
                      ),
                      activeIcon: Container(
                        padding: EdgeInsets.only(bottom: 4.h),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 12),
                          )
                        ]),
                        child: Image.asset(
                            'assets/images/icon_category_active.png'),
                      ),
                      label: 'دسته بندی'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Image.asset('assets/images/icon_home.png'),
                      ),
                      activeIcon: Container(
                        padding: EdgeInsets.only(bottom: 4.h),
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: CustomColors.blue,
                            blurRadius: 20,
                            spreadRadius: -7,
                            offset: Offset(0, 12),
                          )
                        ]),
                        child:
                            Image.asset('assets/images/icon_home_active.png'),
                      ),
                      label: 'خانه'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getLayout() => <Widget>[
        const ProfileScreen(),
        const CartScreen(),
        const CategoryScreen(),
        const HomeScreen(),
      ];
}
