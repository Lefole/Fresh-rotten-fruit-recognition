import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  SplashScreenController();
  @override
  void onReady() {
    super.onReady();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  navigateToCamera(BuildContext context) {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      Navigator.of(context).pushReplacementNamed("cameraScreen");
    });
  }
}
