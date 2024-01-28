import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:image/image.dart' as imglib;

class CameraCaptureController {
  CameraController cameraController;

  CameraCaptureController({required this.cameraController});

  void stopImageStream() async {
    if (cameraController.value.isInitialized) {
      try {
        await cameraController.stopImageStream();
      } on CameraException catch (e) {
        log("Camera was not streaming: $e");
      }
    }
  }

  Future<XFile> takePicture() async {
    stopImageStream();
    late XFile picture;
    try {
      cameraController.setFlashMode(FlashMode.off);
      picture = await cameraController.takePicture();
      cameraController.setFlashMode(FlashMode.off);
    } on CameraException catch (e) {
      log("Error taking picture: $e");
    }
    return picture;
  }

  Future<String> savePictureAsJPG(XFile picture) async {
    try {
      List<int> imageBytes = await File(picture.path).readAsBytes();
      imglib.Image? image = imglib.decodeImage(Uint8List.fromList(imageBytes));

      if (image != null) {
        File jpegFile = File(picture.path);
        await jpegFile.writeAsBytes(imglib.encodeJpg(image));
        //await GallerySaver.saveImage(jpegFile.path);
        log("Picture path: ${picture.path}");
      }
    } catch (e) {
      log("Error: $e");
    }
    return picture.path;
  }

  void navigateToPictureScreen(BuildContext context, String imagePath) {
    stopImageStream();
    //TODO: arreglar dispose
    // Future.delayed(
    //     const Duration(milliseconds: 500), () => cameraController.dispose());
    //.find<PictureScreenController>().init(imagePath, "A", "");
    Navigator.pushNamed(context, 'pictureScreen');
  }
}
