import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/cart_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('basketBox');
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
  int basketItemListLength = 0;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) {
            var bloc = HomeBloc();
            bloc.add(HomeGetInitializeData());
            return bloc;
          },
          child: Scaffold(
            body: IndexedStack(
              children: getLayout(),
              index: selectedBottomNavigationIndex,
            ),
            bottomNavigationBar: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: BlocProvider<BasketBloc>.value(
                  value: locator.get<BasketBloc>(),
                  child: BlocConsumer<BasketBloc, BasketState>(
                    listener: (context, state) {
                      if (state is BasketDataFetchedState) {
                        state.basketItemList.fold((l) => '', (r) {
                          basketItemListLength = r.length;
                        });
                      }
                    },
                    builder: (context, state) {
                      return BottomNavigationBar(
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
                                child:
                                    SvgPicture.asset('assets/icons/user.svg'),
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
                                child: SvgPicture.asset(
                                    'assets/icons/user-filled.svg'),
                              ),
                              label: 'حساب کاربری'),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: SizedBox(
                                  width: 50.w,
                                  child: basketItemListLength > 0
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/bag.svg'),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(
                                                width: 15,
                                                height: 15,
                                                decoration: const BoxDecoration(
                                                    color: CustomColors.red,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Text(
                                                    basketItemListLength
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontFamily: 'SB',
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/bag.svg'),
                                ),
                              ),
                              activeIcon: Container(
                                width: 50.w,
                                padding: EdgeInsets.only(bottom: 4.h),
                                decoration: const BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: CustomColors.blue,
                                    blurRadius: 20,
                                    spreadRadius: -7,
                                    offset: Offset(0, 12),
                                  )
                                ]),
                                child: basketItemListLength > 0
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/bag-filled.svg'),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              width: 15,
                                              height: 15,
                                              decoration: const BoxDecoration(
                                                  color: CustomColors.red,
                                                  shape: BoxShape.circle),
                                              child: Center(
                                                child: Text(
                                                  basketItemListLength
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily: 'SB',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/bag-filled.svg'),
                              ),
                              label: 'سبد خرید'),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: SvgPicture.asset(
                                    'assets/icons/category.svg'),
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
                                child: SvgPicture.asset(
                                    'assets/icons/category-filled.svg'),
                              ),
                              label: 'دسته بندی'),
                          BottomNavigationBarItem(
                              icon: Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child:
                                    SvgPicture.asset('assets/icons/home.svg'),
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
                                child: SvgPicture.asset(
                                    'assets/icons/home-filled.svg'),
                              ),
                              label: 'خانه'),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getLayout() => <Widget>[
        const ProfileScreen(),
        BlocProvider(
          create: (context) {
            var bloc = locator.get<BasketBloc>();
            bloc.add(BasketFetchFromHiveEvent());
            return bloc;
          },
          child: const CartScreen(),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(),
          child: const CategoryScreen(),
        ),
    const Directionality(
          textDirection: TextDirection.rtl,
          child: HomeScreen(),
        ),
      ];
}
