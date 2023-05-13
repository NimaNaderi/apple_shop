import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../bloc/categoryProduct/category_product_bloc.dart';
import '../constants/colors.dart';

class ProductListScreen extends StatefulWidget {
  Category category;
  ProductListScreen(this.category, {super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    context
        .read<CategoryProductBloc>()
        .add(CategoryProductInitialized(widget.category.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: BlocBuilder<CategoryProductBloc, CategoryProductState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is CategoryProductLoading) ...{
                  SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        LoadingAnimationWidget.beat(
                            color: CustomColors.blue, size: 32),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          'درحال دریافت محصولات',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SB',
                              color: CustomColors.grey),
                        )
                      ],
                    ),
                  ),
                },
                if (state is CategoryProductSuccess) ...{
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 44.w,
                        right: 44.w,
                        bottom: 32.h,
                        top: 16.h,
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
                            SvgPicture.asset('assets/icons/apple.svg',
                                color: CustomColors.blue, width: 24.w),
                            Expanded(
                              child: Text(
                                widget.category.title!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 16.sp,
                                  color: CustomColors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  state.productListByCategory.fold(
                      (l) => const SliverToBoxAdapter(
                            child: Text('خطا'),
                          ),
                      (productList) => SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 44.w),
                            sliver: SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                childCount: productList.length,
                                (context, index) =>
                                    ProductItem(productList[index]),
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 30,
                                childAspectRatio: 2 / 3,
                              ),
                            ),
                          )),
                },
                SliverPadding(padding: EdgeInsets.only(top: 16.h)),
              ],
            );
          },
        ),
      ),
    );
  }
}
