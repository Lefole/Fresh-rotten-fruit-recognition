import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img_lib;
import 'package:permission_handler/permission_handler.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detected_api.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/controllers/picture_screen_controller.dart';

class CameraConfigurationController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  var isDetecting = false;
  var isCameraInitialized = false.obs;
  bool photoTaken = false;

  ObjectDetectedResponse objectDetected =
      ObjectDetectedResponse.defaultResponse();

  final objectDetectedApi = ObjectDetectedApi();

  @override
  onInit() {
    super.onInit();
    initCamera();
  }

  //CAMERA INIT
  void initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max,
          enableAudio: false);
      await cameraController.initialize().then((value) => startImageStream());
      isCameraInitialized(true);
      update();
    } else {
      log("Permission denied");
    }
  }

  //IMAGE STREAM
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

  void objectDetector(CameraImage image) async {
    final response = await objectDetectedApi.getObjectDetected(
      image.height,
      image.width,
      image.planes[0].bytes,
      image.planes[1].bytes,
      image.planes[2].bytes,
      image.planes[1].bytesPerPixel ?? 0,
      image.planes[1].bytesPerRow,
    );
    objectDetected = response;
    isDetecting = false;
    update();
  }

  void stopImageStream() async {
    if (cameraController.value.isInitialized) {
      try {
        await cameraController.stopImageStream();
      } on CameraException catch (e) {
        log("Camera was not streaming: $e");
      }
    }
  }

  //CAMERA IMAGE
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

  void takePictureAndNavigate() async {
    photoTaken = true;
    update();

    stopImageStream();
    XFile picture = await takePicture();
    final path = picture.path;
    final bytes = await File(path).readAsBytes();
    final img_lib.Image? image = img_lib.decodeImage(bytes);

    List<int> jpg = img_lib.encodeJpg(image!);
    String base64Image = base64Encode(jpg);
    final response =
        await objectDetectedApi.getObjectDetectedByJPG(base64Image);
    objectDetected = response;
    photoTaken = false;
    update();
    navigateToPictureScreen(picture.path);
  }

  void navigateToPictureScreen(String imagePath) {
    PictureScreenController pictureScreenController = Get.put(
      PictureScreenController(),
    );
    pictureScreenController.init(imagePath, objectDetected.label,
        objectDetected.confidence, objectDetected);
    Get.toNamed("/picture_screen");
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }
}
