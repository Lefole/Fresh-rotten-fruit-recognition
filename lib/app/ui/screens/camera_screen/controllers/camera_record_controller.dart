import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter_meedu/notifiers.dart';

class CameraRecordController extends StateNotifier {
  CameraRecordController(super.initialState);

  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(cameras[0], ResolutionPreset.max);
        await cameraController.initialize();
        isCameraInitialized = true;
        log("HOLo");
      } else {
        log("No hay cámaras disponibles");
      }
    } catch (e) {
      log("Error on camera: $e");
    }
  }

  init() {
    initCamera();
  }
}



// Future<void> initCamera() async {
//   try {
//     cameras = await availableCameras();
//     if (cameras.isNotEmpty) {
//       cameraController = CameraRecordController(cameras[0], ResolutionPreset.max);
//       await cameraController.initialize().then((value) => ());
//       isCameraInitialized = true;
//     } else {
//       log("No hay cámaras disponibles");
//     }
//   } catch (e) {
//     log("Error on camera: $e");
//   }
// }
