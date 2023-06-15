import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class PurchaseSuccessCelebration extends StatelessWidget {
  const PurchaseSuccessCelebration({super.key,required this.confettiController});

  final ConfettiController confettiController;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      shouldLoop: false,
      emissionFrequency: 0,
      numberOfParticles: 10,
      blastDirectionality: BlastDirectionality.directional,
    );
  }
}
