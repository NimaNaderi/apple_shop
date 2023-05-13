import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/category/category_event.dart';
import 'package:apple_shop/bloc/category/category_state.dart';
import 'package:apple_shop/bloc/categoryProduct/category_product_bloc.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/screens/product_list_screen.dart';
import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryRequest());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 44.w,
                  right: 44.w,
                  bottom: 32.h,
                  top: 20.h,
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
                          'جستجوی محصولات',
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
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                // if (state is CategoryLoadingState) {
                //   return SliverToBoxAdapter(child: CircularProgressIndicator());
                // }

                if (state is CategoryResponseState) {
                  return state.response.fold((l) {
                    return SliverToBoxAdapter(
                      child: Text(l),
                    );
                  }, (r) {
                    return _categoryList(categoryList: r);
                  });
                }

                return SliverToBoxAdapter(child: Text('data'));
              },
            ),
            SliverPadding(padding: EdgeInsets.only(top: 20.h))
          ],
        ),
      ),
    );
  }
}

class _categoryList extends StatelessWidget {
  List<Category>? categoryList;

  _categoryList({Key? key, required this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 44.w),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CategoryProductBloc(),
                    child: ProductListScreen(categoryList![index]),
                  ),
                ));
              },
              child: CachedImage(imageUrl: categoryList?[index].thumbnail!)),
          childCount: categoryList?.length ?? 0,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}
