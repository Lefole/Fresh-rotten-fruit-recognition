import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rotten_fruit_recognition/app/domain/models/object_detected_model.dart';

class ObjectDetectedApi {
  Dio dio = Dio(
    BaseOptions(baseUrl: 'localhost'),
  );

  Future<ObjectDetectedModel> getObjectDetected() async {
    final response = await dio.get("");
    log(response.toString());
    return ObjectDetectedModel(
      "label",
      60,
      60,
      100,
      100,
    );
  }
}
