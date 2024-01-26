import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_capture_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_configuration_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_stream_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/widgets/take_pic_button.dart';
import 'package:rotten_fruit_recognition/app/ui/widgets/object_detected_box_widget.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    log("CONTEXT SCREEN: $screenHeight -$screenWidth");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          "Detección del estado de frutas",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<CameraConfigurationController>(
        init: CameraConfigurationController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        CameraPreview(
                          controller.cameraController,
                        ),
                        (controller.objectDetected.confidence > 0.7)
                            ? ObjectDetectedBoxWidget(
                                y: controller.objectDetected.y,
                                x: controller.objectDetected.x,
                                h: controller.objectDetected.h,
                                w: controller.objectDetected.w,
                                label: controller.objectDetected.label,
                              )
                            : const SizedBox(),
                        // GetBuilder<CameraStreamController>(
                        //     builder: (stream_controller) {
                        //   return (stream_controller.objectDetected.confidence >
                        //           0.7)
                        //       ? ObjectDetectedBoxWidget(
                        //           y: stream_controller.objectDetected.y,
                        //           x: stream_controller.objectDetected.x,
                        //           h: stream_controller.objectDetected.h,
                        //           w: stream_controller.objectDetected.w,
                        //           label: controller.objectDetected.label,
                        //         )
                        //       : const SizedBox();
                        // }),
                      ],
                    ),
                    Container(
                      height: 174,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Center(
                        child: TakePictureButton(
                          captureController: CameraCaptureController(
                            cameraController: controller.cameraController,
                          ),
                          isCameraInitialized:
                              controller.isCameraInitialized.value,
                        ),
                      ),
                    ),
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
