import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/screen_utils.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;
  late CameraImage cameraImage;
  var cameraCount = 0;
  Map<String, dynamic> objectDetected = {
    'label': 'AAAA',
    'x': 20.0,
    'y': 20.0,
    'h': 2.0,
    'w': 2.0,
  };

  @override
  void initState() {
    super.initState();
    initCamera();
    initTFLite();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        cameraController = CameraController(cameras[0], ResolutionPreset.max);
        await cameraController.initialize().then((value) {
          cameraController.startImageStream((image) {
            cameraCount++;
            if (cameraCount % 10 == 0) {
              cameraCount = 0;
              setState(() {});
              objectDetector(image);
            }
          });
          setState(() {});
        });
        if (mounted) {
          isCameraInitialized = true;
          setState(() {});
        }
      } else {
        log("No hay cámaras disponibles");
      }
    } catch (e) {
      log("Error al inicializar la cámara: $e");
    }
  }

  Future<void> initTFLite() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  void objectDetector(CameraImage image) {
    var detector = Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) => e.bytes).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      rotation: 90,
      threshold: 0.4,
    );
    log("RESULT IS: $detector");
  }

  @override
  void dispose() {
    cameraController.dispose();
    isCameraInitialized = false;
    setState(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: isCameraInitialized
            ? Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(cameraController),
                  Positioned(
                    top: objectDetected['x'],
                    left: objectDetected['y'],
                    child: Container(
                      height: objectDetected['h'] * context.height / 100,
                      width: objectDetected['w'] * context.width / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                ),
                                border: Border.all(color: Colors.green),
                                color: Colors.green),
                            child: Text(
                              objectDetected['label'],
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
