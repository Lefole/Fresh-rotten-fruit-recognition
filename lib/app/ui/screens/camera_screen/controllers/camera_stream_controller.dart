import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detected_api.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';

class CameraStreamController extends GetxController {
  CameraController cameraController;
  bool isDetecting = false;
  ObjectDetectedResponse objectDetected =
      ObjectDetectedResponse.defaultResponse();
  final objectDetectedApi = ObjectDetectedApi();

  CameraStreamController({required this.cameraController});

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
      "Nombre";
      "estado";
      "cuadrado de poscion [1,2],[3,4]"
          "porcentaje acierto";
      //TODO: ARREGLAR CONEXIÓN DIO

      // final response = await objectDetectedApi.getObjectDetected(
      //   image.height,
      //   image.width,
      //   image.planes[0].bytes,
      //   image.planes[1].bytes,
      //   image.planes[2].bytes,
      // );
      //objectDetected = response;
    } on DioException catch (e) {
      log("ERROR: $e");
      objectDetected = ObjectDetectedResponse.defaultResponse();
    }
    isDetecting = false;
    update();
  }
}
