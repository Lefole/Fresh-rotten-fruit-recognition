import 'package:rotten_fruit_recognition/app/domain/models/object_detected_model.dart';
import 'package:rotten_fruit_recognition/app/domain/repository/object_detected_respository.dart';
import 'package:rotten_fruit_recognition/app/data/api/object_detect_api.dart';

class ObjectDetectedRepositoryImp extends ObjectDetectedRepository {
  final ObjectDetectedApi api;

  ObjectDetectedRepositoryImp(this.api);

  @override
  Future<ObjectDetectedModel> getObjectDetected() => api.getObjectDetected();
}
