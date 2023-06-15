import 'dart:ui';

import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/features/auth/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../features/cart/presentation/bloc/basket_bloc.dart';
import '../bloc/category/category_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../common/constants/colors.dart';
import '../config/di/di.dart';
import '../features/cart/presentation/bloc/basket_event.dart';
import '../features/cart/presentation/bloc/basket_state.dart';
import '../features/cart/presentation/screens/cart_screen.dart';
import 'category_screen.dart';
import 'home_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int selectedBottomNavigationIndex = 3;
  int basketItemListLength = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: selectedBottomNavigationIndex, children: getLayout()),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: BlocProvider<BasketBloc>.value(
            value: locator.get<BasketBloc>(),
            child: BlocConsumer<BasketBloc, BasketState>(
              listener: (context, state) {
                if (state is BasketDataFetchedState ||
                    state is TransactionResponseState) {
                  if (state is BasketDataFetchedState) {
                    state.basketItemList.fold((l) => '', (r) {
                      basketItemListLength = r.length;
                    });
                  } else if (state is TransactionResponseState &&
                      state.transaction.isSuccess) {
                    basketItemListLength = 0;
                  }
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
                          child:
                          SvgPicture.asset('assets/icons/user-filled.svg'),
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
                                SvgPicture.asset('assets/icons/bag.svg'),
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
                                        basketItemListLength.toString(),
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
                                : SvgPicture.asset('assets/icons/bag.svg'),
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
                                      basketItemListLength.toString(),
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
                              : SvgPicture.asset('assets/icons/bag-filled.svg'),
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
                          child: SvgPicture.asset(
                              'assets/icons/category-filled.svg'),
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> getLayout() =>
    <Widget>[
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
      BlocProvider(
        create: (context) {
          HomeBloc homeBloc = HomeBloc();
          homeBloc.add(HomeGetInitializeData());
          return homeBloc;
        },
        child: const Directionality(
          textDirection: TextDirection.rtl,
          child: HomeScreen(),
        ),
      ),
    ];
