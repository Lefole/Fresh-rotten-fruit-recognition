import 'package:get/get.dart';

class PictureScreenController extends GetxController {
  String imageFilePath = "";
  String fruitName = "";
  String state = "";
  String description = "";
  double confidencePercentage = 0.0;

  void init(String path, String fruitName, String state) {
    imageFilePath = path;
    this.fruitName = fruitName;
    this.state = state;
    update();
  }
}
