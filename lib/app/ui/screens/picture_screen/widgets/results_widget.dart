import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultsWidget extends StatelessWidget {
  const ResultsWidget({
    super.key,
  });

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
            LottieBuilder.asset(
              "assets/lotties/fresh_fruit.json",
              width: 150,
            ),
            const Expanded(child: SizedBox()),
            const SizedBox(
              width: 150,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    value: 0.8,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Identificado con un 99% de coincidencia",
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
