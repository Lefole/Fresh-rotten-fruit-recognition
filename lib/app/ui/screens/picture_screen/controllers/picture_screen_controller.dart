import 'dart:developer';

import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_configuration_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/picture_screen.dart';

class PictureScreenController extends GetxController {
  String imageFilePath = "";
  bool isFresh = false;
  String fruitName = "";
  String fruitState = "";
  String fruitDescription = "";
  double confidencePercentage = 0.0;

  void init(String path, String label, double confidence) {
    //define fresh
    if (label.contains("Fresh")) {
      isFresh = true;
    } else {
      isFresh = false;
    }
    //define name
    imageFilePath = path;

    fruitName = label.split(" ")[0];
    fruitState = label.split(" ")[1];
    if (isFresh) {
      fruitDescription =
          "Consumir frutas frescas aporta una variedad de beneficios para la salud. Estas están repletas de vitaminas, minerales y antioxidantes esenciales que son fundamentales para el funcionamiento óptimo del cuerpo. Las frutas frescas son una fuente natural de fibra, promoviendo la salud digestiva y ayudando en la prevención de problemas como el estreñimiento.";
    } else {
      fruitDescription =
          "Comer frutas en estado de descomposición puede tener consecuencias adversas para la salud debido a la presencia de microorganismos y toxinas que se desarrollan durante el proceso de deterioro. La ingestión de frutas podridas puede llevar a infecciones alimentarias, manifestándose con síntomas como náuseas, vómitos, diarrea y fiebre debido a la presencia de bacterias patógenas";
    }
    confidencePercentage = confidence;
    update();
  }

  void navigateBackToCamera() {
    CameraConfigurationController cameraScreenController = Get.put(
      CameraConfigurationController(),
    );
    cameraScreenController.initCamera();
  }
}
