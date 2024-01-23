import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as imgLib;
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detected_api.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/detected_screen/detected_object_screen.dart';

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
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      //cameraController.setFlashMode(FlashMode.auto);
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

  void stopImageStream() {
    cameraController.stopImageStream();
  }

  objectDetector(CameraImage image) async {
    try {
      log(image.format.group.name);
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

  captureImage(bool isCameraInitialized, CameraController cameraController,
      BuildContext context) async {
    if (isCameraInitialized) {
      stopImageStream();
      late XFile picture;
      try {
        picture = await cameraController.takePicture();
      } on CameraException catch (e) {
        log("Error al tomar la foto: $e");
        return;
      }
      try {
        List<int> imageBytes = await File(picture.path).readAsBytes();
        imgLib.Image? image =
            imgLib.decodeImage(Uint8List.fromList(imageBytes));

        if (image != null) {
          File jpegFile = File(picture.path);
          //await jpegFile.writeAsBytes(imgLib.encodeJpg(image));
          //await GallerySaver.saveImage(jpegFile.path);
          log("Imagen guardada como JPEG en: ${picture.path}");
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => DetectedObjectScreen(),
          ));
        }
      } catch (e) {
        log("Error al procesar la foto: $e");
      }
      //startImageStream();
    }
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }
}
