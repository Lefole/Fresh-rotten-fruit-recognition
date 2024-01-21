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
import 'package:image/image.dart' as img;

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
      Uint8List uint8List = cameraImageToByteList(image);
      img.Image? imgData = img.decodeImage(uint8List);

      if (imgData != null) {
        // Encode the image to JPEG format
        Uint8List jpegData = img.encodeJpg(imgData);

        // Send the JPEG data to the API
        final response = await objectDetectedApi.getObjectDetected(jpegData);
        objectDetected = response;
      } else {
        log("ERROR METHOD: Failed to decode image");
        objectDetected = ObjectDetectedResponse.defaultResponse();
      }
    } catch (e) {
      log("ERROR METHOD: $e");
      objectDetected = ObjectDetectedResponse.defaultResponse();
    }
    isDetecting = false;
    update();
  }

  Uint8List cameraImageToByteList(CameraImage image) {
    // Convert CameraImage to Uint8List
    var plane = image.planes[0];
    var bytes = plane.bytes;
    return Uint8List.fromList(bytes);
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }
}
