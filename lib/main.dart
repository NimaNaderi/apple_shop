import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/basket/basket_event.dart';
import 'package:apple_shop/bloc/basket/basket_state.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/config/theme/app_theme.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_item.dart';
import 'package:apple_shop/data/model/basket_item_variant.dart';
import 'package:apple_shop/data/model/variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/data/model/variant_type_enum.dart';
import 'package:apple_shop/di/di.dart';
import 'package:apple_shop/screens/cart_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';
import 'package:apple_shop/screens/profile_screen.dart';
import 'package:apple_shop/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  Hive.registerAdapter(BasketItemVariantAdapter());
  Hive.registerAdapter(VariantAdapter());
  Hive.registerAdapter(VariantTypeEnumAdapter());
  Hive.registerAdapter(VariantTypeAdapter());
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
        theme: AppTheme.light,
        home: const WelcomeScreen(),
      ),
    );
  }
}
