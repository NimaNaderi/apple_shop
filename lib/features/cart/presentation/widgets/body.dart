import 'package:apple_shop/features/cart/presentation/widgets/order_summary.dart';
import 'package:apple_shop/features/cart/presentation/widgets/transaction_detail.dart';
import 'package:confetti/confetti.dart';
import 'package:davinci/core/davinci_capture.dart';
import 'package:davinci/core/davinci_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/utils/utils.dart';
import '../../../../common/widgets/project_appbar.dart';
import '../../../../config/theme/app_colors.dart';
import '../bloc/basket_bloc.dart';
import '../bloc/basket_event.dart';
import '../bloc/basket_state.dart';
import 'cart_item.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key, required this.confettiController});
  final ConfettiController confettiController;

  @override
  Widget build(BuildContext context) {
    GlobalKey? imageKey;
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) => Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 44.w,
                      right: 44.w,
                      bottom: 32.h,
                      top: 20.h,
                    ),
                    child: const ProjectAppBar(
                      appbarTitle: 'سبد خرید',
                    ),
                  ),
                ),
                if (state is BasketDataFetchedState) ...[
                  state.basketItemList.fold(
                    (l) => SliverToBoxAdapter(
                      child: Text(l),
                    ),
                    (basketItemList) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => CartItem(basketItemList[index]),
                          childCount: basketItemList.length),
                    ),
                  ),
                  if (state.basketSummary[0] != 0) ...{
                    SliverToBoxAdapter(
                      child: OrderSummary(basketSummary: state.basketSummary),
                    )
                  },
                  if (state.basketSummary[0] == 0) ...{
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .4,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'سبد خرید شما خالی است',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  },
                ],
                if (state is TransactionResponseState) ...[
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/icon-${state.transaction.isSuccess ? 'success' : 'error'}.svg',
                            height: 40.h,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            state.transaction.isSuccess
                                ? '!پرداخت با موفقیت انجام شد'
                                : '!پرداخت ناموفق بود',
                            style: theme.textTheme.labelLarge!.copyWith(
                                color: state.transaction.isSuccess
                                    ? const Color(0xff23A16D)
                                    : AppColors.red),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            ' ${state.transaction.totalPrice} تومان ',
                            textDirection: TextDirection.rtl,
                            style: theme.textTheme.displayLarge!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Davinci(
                            builder: (key) {
                              if (state.transaction.isSuccess) {
                                confettiController.play();
                              }
                              imageKey = key;
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey.withOpacity(0.15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'جزییات تراکنش',
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      shrinkWrap: true,
                                      itemCount: 7,
                                      itemBuilder: (context, index) =>
                                          TransactionDetail(
                                              title: Utils.getTransactionData(
                                                  state.transaction)[index][0],
                                              value: Utils.getTransactionData(
                                                  state.transaction)[index][1],
                                              index: index),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  if (state.transaction.isSuccess) ...{
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 44.w, left: 44.w, bottom: 20.h),
                        child: SizedBox(
                          height: 54.h,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              await DavinciCapture.click(imageKey!,
                                  saveToDevice: true,
                                  // pixelRatio: 10,
                                  openFilePreview: true,
                                  fileName: 'apple_shop_screenshot',
                                  context: context);
                            },
                            child: Text(
                              'ذخیره عکس از رسید پرداخت',
                              textDirection: TextDirection.rtl,
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ),
                      ),
                    )
                  }
                ],
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 100.h),
                )
              ],
            ),
            if ((state is BasketDataFetchedState &&
                state.basketSummary[0] != 0)) ...[
              Padding(
                padding: EdgeInsets.only(right: 44.w, left: 44.w, bottom: 20.h),
                child: SizedBox(
                  height: 54.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<BasketBloc>()
                          .add(BasketPaymentRequestEvent());
                    },
                    child: !state.isPaymentLoading
                        ? Text(
                            'ادامه فرایند خرید',
                            textDirection: TextDirection.rtl,
                            style: theme.textTheme.labelLarge,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  'درحال ورود به درگاه پرداخت',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
