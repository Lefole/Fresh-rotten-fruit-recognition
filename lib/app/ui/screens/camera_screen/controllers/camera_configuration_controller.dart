import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_stream_controller.dart';

class CameraConfigurationController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isDetecting = false;
  var isCameraInitialized = false.obs;

  ObjectDetectedResponse objectDetected =
      ObjectDetectedResponse.defaultResponse();

  @override
  onInit() {
    super.onInit();
    initCamera();
  }

  void initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      cameraController.setFlashMode(FlashMode.off);
      await cameraController.initialize().then((value) =>
          CameraStreamController(cameraController: cameraController)
              .startImageStream());
      isCameraInitialized(true);
      update();
    } else {
      log("Permission denied");
    }
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }
}
