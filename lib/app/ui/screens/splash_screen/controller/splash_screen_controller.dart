import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/camera_screen.dart';

class SplashScreenController extends GetxController {
  BuildContext context;

  SplashScreenController({required this.context});
  @override
  void onReady() {
    super.onReady();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  navigateToCamera() {
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const CameraScreen()));
    });
  }
}
