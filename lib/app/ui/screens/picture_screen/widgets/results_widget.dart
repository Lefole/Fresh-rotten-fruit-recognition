import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultsWidget extends StatelessWidget {
  final bool isFresh;
  final double confidencePercentage;
  const ResultsWidget(
      {super.key, required this.isFresh, required this.confidencePercentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Resultados",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isFresh)
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.141), // Gira horizontalmente
                child: LottieBuilder.asset(
                  "assets/lotties/rotten_fruit_2.json",
                  width: 150,
                ),
              )
            else
              LottieBuilder.asset(
                "assets/lotties/fresh_fruit.json",
                width: 150,
              ),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: 150,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    value: confidencePercentage,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Identificado con un ${(confidencePercentage * 100).toStringAsFixed(1)}% de coincidencia",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
