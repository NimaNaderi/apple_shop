import 'package:apple_shop/common/constants/colors.dart';
import 'package:apple_shop/features/cart/presentation/widgets/body.dart';
import 'package:apple_shop/features/cart/presentation/widgets/success_celebration.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfettiController controller = ConfettiController();
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Scaffold(
          backgroundColor: CustomColors.backgroundScreenColor,
          body: CartBody(confettiController: controller),
        ),
        PurchaseSuccessCelebration(confettiController: controller)
      ],
    );
  }
}
