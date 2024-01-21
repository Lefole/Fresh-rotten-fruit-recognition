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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text(
          "Clasificador de cabros",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GetBuilder<CameraRecordController>(
        init: CameraRecordController(),
        builder: (controller) {
          return controller.isCameraInitialized.value
              ? Stack(
                  fit: StackFit.loose,
                  children: [
                    CameraPreview(controller.cameraController),
                    (controller.objectDetected.label != "")
                        ? ObjectDetectedBoxWidget(
                            x: controller.objectDetected.x,
                            y: controller.objectDetected.y,
                            h: controller.objectDetected.h,
                            w: controller.objectDetected.w,
                            label: controller.objectDetected.label,
                          )
                        : const SizedBox(),
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
