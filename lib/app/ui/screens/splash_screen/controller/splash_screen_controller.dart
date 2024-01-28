import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    checkPermissionsAndNavigate();
  }

  void checkPermissionsAndNavigate() async {
    final cameraPermission = await Permission.camera.request().isGranted;
    final storagePermission = await Permission.storage.request().isGranted;

    if (cameraPermission && storagePermission) {
      navigateToCamera();
    } else {
      SystemNavigator.pop();
    }
  }

  void navigateToCamera() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        Get.offAndToNamed("/camera_screen");
      },
    );
  }
}
