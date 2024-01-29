import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/controllers/picture_screen_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/widgets/description_widget.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/widgets/results_widget.dart';
import 'package:rotten_fruit_recognition/app/ui/widgets/object_detected_box_widget.dart';

class PictureScreen extends StatelessWidget {
  const PictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PictureScreenController>(
      init: PictureScreenController(),
      builder: (controller) {
        return PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            if (didPop) controller.navigateBackToCamera();
          },
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              title: const Text(
                "Estado fruta",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: (controller.imageFilePath != "")
                        ? Stack(
                            fit: StackFit.loose,
                            children: [
                              Image.file(File(controller.imageFilePath)),
                              (controller.objectHasBeenDetected)
                                  ? ObjectDetectedBoxWidget(
                                      y: controller.objectDetected.y,
                                      x: controller.objectDetected.x,
                                      h: controller.objectDetected.h,
                                      w: controller.objectDetected.w,
                                      label: controller.objectDetected.label,
                                    )
                                  : const SizedBox()
                            ],
                          )
                        : const SizedBox(),
                  ),
                  (controller.objectHasBeenDetected)
                      ? ListTile(
                          title: Text("Fruta: ${controller.fruitName}"),
                          subtitle: Text("Estado: ${controller.fruitState}"),
                          trailing: (controller.isFresh)
                              ? const Icon(
                                  Icons.check_circle_outline_outlined,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.dangerous_outlined,
                                  color: Colors.red,
                                ),
                          titleTextStyle: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        )
                      : const ListTile(
                          title: Text("Fruta: Sin identificar"),
                          subtitle: Text("No se ha reconocido ninguna fruta"),
                        ),
                  (controller.objectHasBeenDetected)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    DescriptionWidget(
                                        description:
                                            controller.fruitDescription),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    ResultsWidget(
                                      isFresh: controller.isFresh,
                                      confidencePercentage:
                                          controller.confidencePercentage,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
