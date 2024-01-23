import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as imgLib;
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_configuration_controller.dart';

class TakePictureButton extends StatelessWidget {
  final CameraRecordController controller;
  final bool isCameraInitialized;

  TakePictureButton({
    Key? key,
    required this.controller,
    required this.isCameraInitialized,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.captureImage(
        isCameraInitialized,
        controller.cameraController,
        context,
      ),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Center(
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
