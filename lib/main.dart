import 'dart:ui';

import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/cart_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedBottomNavigationIndex = 3;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: IndexedStack(
            children: getLayout(),
            index: selectedBottomNavigationIndex,
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
                        child: SvgPicture.asset('assets/icons/user.svg'),
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
                        child: SvgPicture.asset('assets/icons/user-filled.svg'),
                      ),
                      label: 'حساب کاربری'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset('assets/icons/bag.svg'),
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
                        SvgPicture.asset('assets/icons/bag-filled.svg'),
                      ),
                      label: 'سبد خرید'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset('assets/icons/category.svg'),
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
                        child: SvgPicture.asset('assets/icons/category-filled.svg'),
                      ),
                      label: 'دسته بندی'),
                  BottomNavigationBarItem(
                      icon: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: SvgPicture.asset('assets/icons/home.svg'),
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
                            SvgPicture.asset('assets/icons/home-filled.svg'),
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
        BlocProvider(
          create: (context) => CategoryBloc(),
          child: CategoryScreen(),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider(
            create: (context) => HomeBloc(),
            child: HomeScreen(),
          ),
        ),
      ];
}
