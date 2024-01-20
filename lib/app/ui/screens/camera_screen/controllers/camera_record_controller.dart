import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraRecordController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isDetecting = false;
  var cameraCount = 0;
  var isCameraInitialized = false.obs;
  final Map<String, dynamic> objectDetected = {
    'x': 0.0,
    'y': 0.0,
    'h': 0.0,
    'w': 0.0,
    'label': ""
  };

  @override
  onInit() {
    super.onInit();
    initCamera();
    initTFLite();
  }

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );
      await cameraController.initialize().then(
        (value) {
          startImageStream();
        },
      );
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
        //objectDetector(image);
      }
      update();
    });
  }

  // initTFLite() async {
  //   await Tflite.loadModel(
  //     model: "assets/model.tflite",
  //     labels: "assets/labels.txt",
  //     isAsset: true,
  //     numThreads: 1,
  //     useGpuDelegate: false,
  //   );
  // }

  // initTFLite() async {
  //   await Tflite.loadModel(
  //     model: "assets/mobilenet_v1_1.0_224.tflite",
  //     labels: "assets/mobilenet_v1_1.0_224.txt",
  //     isAsset: true,
  //     numThreads: 4,
  //     useGpuDelegate: false,
  //   );
  // }

  initTFLite() async {
    await Tflite.loadModel(
      model: "assets/ssd_mobilenet.tflite",
      labels: "assets/ssd_mobilenet.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  objectDetector(CameraImage image) {
    var detector = Tflite.detectObjectOnFrame(
      bytesList: image.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      model: "SSDMobileNet",
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      rotation: 90,
      threshold: 0.4,
    ).then((value) {
      if (value != null) {
        isDetecting = false;
        final object = value.first;
        if (object['confidence'] > 0.4) {
          objectDetected['x'] = object['rect']['x'];
          objectDetected['y'] = object['rect']['y'];
          objectDetected['h'] = object['rect']['h'];
          objectDetected['w'] = object['rect']['w'];
          objectDetected['label'] = object['label'];
          log("${objectDetected['confidence']}-${objectDetected['label']}");
        }
      }
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }
}
