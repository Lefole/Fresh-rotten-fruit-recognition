import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/splash_screen/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashScreenController().navigateToCamera(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.orange],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/lotties/splash_1.json",
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Fresh or Rotten",
                style: GoogleFonts.lemon(
                  fontSize: 40,
                  color: Colors.white,
                ),
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
