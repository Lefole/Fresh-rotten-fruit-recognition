import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_record_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/widgets/object_detected_box_widget.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CameraRecordController>(
        init: CameraRecordController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    CameraPreview(controller.cameraController),
                    ObjectDetectedBoxWidget(
                      // x: controller.objectDetected['x'] * 700,
                      // y: controller.objectDetected['y'] * 500,
                      // h: controller.objectDetected['h'] * context.height,
                      // w: controller.objectDetected['w'] * context.width,
                      x: 50, y: 50, h: 100, w: 100,
                      label: "${controller.objectDetected['label']}",
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
