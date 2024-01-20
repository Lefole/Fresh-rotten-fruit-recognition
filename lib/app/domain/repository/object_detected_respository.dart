import 'package:rotten_fruit_recognition/app/domain/models/object_detected_model.dart';

abstract class ObjectDetectedRepository {
  Future<ObjectDetectedModel> getObjectDetected();
}
