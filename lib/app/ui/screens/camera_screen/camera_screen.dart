import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer/consumer_widget.dart';
import 'package:flutter_meedu/providers.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_record_controller.dart';
//import 'package:tflite/tflite.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';

// final cameraProvider = Provider.state((ref) => CameraRecordController(null));

// class CameraScreen extends StatelessWidget {
//   const CameraScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: double.infinity,
//         child: Consumer(
//           builder: (_, ref, __) {
//             final notifier = ref.watch(cameraProvider);
//             cameraProvider.read().init();
//             return (cameraProvider.read().isCameraInitialized == true)
//                 ? CameraPreview(notifier.cameraController)
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   );
//           },
//         ),
//       ),
//     );
//   }
// }

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;
  var cameraCount = 0;

  @override
  void initState() {
    super.initState();
    initCamera();
    //initTensorFlow();
  }

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras[0], ResolutionPreset.max);
        await _controller.initialize().then(
          (value) {
            cameraCount++;
            if (cameraCount % 10 == 0) {
              _controller.startImageStream((image) => ());
            }
            setState(() {});
          },
        );
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
        setState(() {});
      } else {
        log("No hay cámaras disponibles");
      }
    } catch (e) {
      log("Error al inicializar la cámara: $e");
    }
  }

  // void objectDetector(CameraImage image) {
  //   var detector = Tflite.runModelOnFrame(
  //     bytesList: image.planes.map((e) => e.bytes).toList(),
  //     asynch: true,
  //     imageHeight: image.height,
  //     imageWidth: image.width,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //     numResults: 1,
  //     rotation: 90,
  //     threshold: 0.4,
  //   );
  // }

  // Future<void> initTensorFlowp() async {
  //   final inputs = ["Bananan"];
  //   final outputs = [];
  //   final interpreter = await Interpreter.fromAsset(
  //       "assets/fresh_rotten_fruit_recognition.tflite");
  //   interpreter.run(inputs, outputs);
  // }

  @override
  void dispose() {
    _controller.dispose();
    _isCameraInitialized = false;
    setState(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: _isCameraInitialized
            ? CameraPreview(_controller)
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
