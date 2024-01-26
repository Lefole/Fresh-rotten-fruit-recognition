import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detected_api.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';

class CameraConfigurationController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isDetecting = false;
  var isCameraInitialized = false.obs;

  ObjectDetectedResponse objectDetected =
      ObjectDetectedResponse.defaultResponse();

  final objectDetectedApi = ObjectDetectedApi();

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
      await cameraController.initialize().then((value) => startImageStream());
      isCameraInitialized(true);
      update();
    } else {
      log("Permission denied");
    }
  }

  void startImageStream() {
    cameraController.startImageStream((CameraImage image) {
      if (!isDetecting) {
        isDetecting = true;
        update();
        objectDetector(image);
      }
      update();
    });
  }

  void objectDetector(CameraImage image) async {
    try {
      final response = await objectDetectedApi.getObjectDetected(
        image.height,
        image.width,
        image.planes[0].bytes,
        image.planes[1].bytes,
        image.planes[2].bytes,
        image.planes[1].bytesPerPixel ?? 0,
        image.planes[1].bytesPerRow,
      );
      objectDetected = response;
      log("x: ${objectDetected.x}");
      log("y: ${objectDetected.y}");
      log("h: ${objectDetected.h}");
      log("w: ${objectDetected.w}");
    } on DioException catch (e) {
      log("ERROR: $e");
      objectDetected = ObjectDetectedResponse.defaultResponse();
    }
    isDetecting = false;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }
}
