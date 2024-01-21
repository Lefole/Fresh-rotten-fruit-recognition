import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detected_api.dart';
import 'package:rotten_fruit_recognition/app/domain/models/object_detected_model.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';

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
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );
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

  objectDetector(CameraImage image) async {
    try {
      const MethodChannel _channel = MethodChannel('yuvtransform');
      List<int> strides = Int32List(image.planes.length * 2);
      int index = 0;
      // We need to transform the image to Uint8List so that the native code could
      // transform it to byte[]
      List<Uint8List> data = image.planes.map((plane) {
        strides[index] = (plane.bytesPerRow);
        index++;
        strides[index] = (plane.bytesPerPixel)!;
        index++;
        return plane.bytes;
      }).toList();
      Uint8List imageJpeg = await _channel.invokeMethod('yuvtransform', {
        'platforms': data,
        'height': image.height,
        'width': image.width,
        'strides': strides,
        'quality': 60
      });

      // final response = await objectDetectedApi.getObjectDetected(
      //   image.height,
      //   image.width,
      //   image.planes[0].bytes,
      //   image.planes[1].bytes,
      //   image.planes[2].bytes,
      // );
      final response = await objectDetectedApi.getObjectDetected(imageJpeg);
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
