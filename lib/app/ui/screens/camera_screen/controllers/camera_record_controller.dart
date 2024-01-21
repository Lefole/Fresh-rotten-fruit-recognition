import 'dart:developer';

import 'package:camera/camera.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detected_api.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';
import 'package:image/image.dart' as imglib;
import 'package:yuv_converter/yuv_converter.dart';

class CameraRecordController extends GetxController {
  //PETICION API
  final objectDetectedApi = ObjectDetectedApi();

  //Variable camara
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  //Variables control
  var isDetecting = false;
  var cameraCount = 0;
  var isCameraInitialized = false.obs;

  ObjectDetectedResponse objectDetected =
      ObjectDetectedResponse.defaultResponse();

  @override
  onInit() {
    super.onInit();
    initCamera();
  }

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max,
          imageFormatGroup: ImageFormatGroup.yuv420);
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

  // imglib.Image convertYUV420toRGB(CameraImage image) {
  //   int width = image.width;
  //   int height = image.height;
  //   Uint8List yPlane = image.planes[0].bytes;
  //   Uint8List uPlane = image.planes[1].bytes;
  //   Uint8List vPlane = image.planes[2].bytes;
  //   int uvIndex = 0;

  //   List<int> rgbValues = List<int>.generate(width * height * 3, (index) => 0);
  //   int rgbIndex = 0;

  //   if (width * height * 3 != rgbValues.length) {
  //     // Asegúrate de que el tamaño de rgbValues coincida con el número esperado de píxeles RGB.
  //     throw Exception("Tamaño incorrecto de rgbValues");
  //   }

  //   for (int y = 0; y < height; y++) {
  //     for (int x = 0; x < width; x++) {
  //       if (uvIndex >= uPlane.length || uvIndex >= vPlane.length) {
  //         // Asegúrate de que no excedas el tamaño de los planos de crominancia.
  //         throw Exception("Índice de crominancia fuera de rango");
  //       }

  //       int yValue = yPlane[y * width + x];
  //       int uValue = uPlane[uvIndex];
  //       int vValue = vPlane[uvIndex];
  //       uvIndex++;

  //       int r = (yValue + 1.402 * (vValue - 128)).toInt();
  //       int g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
  //           .toInt();
  //       int b = (yValue + 1.772 * (uValue - 128)).toInt();
  //       r = r.clamp(0, 255);
  //       g = g.clamp(0, 255);
  //       b = b.clamp(0, 255);

  //       if (rgbIndex >= rgbValues.length) {
  //         // Asegúrate de que no excedas el tamaño de rgbValues.
  //         throw Exception("Índice de rgbValues fuera de rango");
  //       }

  //       rgbValues[rgbIndex++] = r;
  //       rgbValues[rgbIndex++] = g;
  //       rgbValues[rgbIndex++] = b;
  //     }
  //   }

  //   if (rgbIndex != rgbValues.length) {
  //     // Asegúrate de que todos los píxeles RGB se han procesado correctamente.
  //     throw Exception("No se procesaron todos los píxeles RGB");
  //   }

  //   return imglib.Image.fromBytes(
  //     width: width,
  //     height: height,
  //     bytes: Uint8List.fromList(rgbValues).buffer,
  //   );
  // }

  objectDetector(CameraImage image) async {
    try {
      final response = await objectDetectedApi.getObjectDetected(
        image.height,
        image.width,
        image.planes[0].bytes,
        image.planes[1].bytes,
        image.planes[2].bytes,
      );
      objectDetected = response;
    } catch (e) {
      log("ERROR METHOD: $e");
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
