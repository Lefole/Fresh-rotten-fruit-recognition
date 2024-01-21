import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:rotten_fruit_recognition/app/domain/response/object_detected_response.dart';

class ObjectDetectedApi {
  Dio dio = Dio(
    BaseOptions(baseUrl: 'http://192.168.3.92:5050/api/v1/'),
  );

  Future<ObjectDetectedResponse> getObjectDetected(
    int height,
    int width,
    Uint8List y,
    Uint8List u,
    Uint8List v,
  ) async {
    ObjectDetectedResponse res;
    try {
      final response = await dio.post(
        "/process_image",
        data: {
          "height": height,
          "width": width,
          "y": y,
          "u": u,
          "v": v,
        },
        options: Options(),
      );
      if (response.statusCode == 200) {
        res = ObjectDetectedResponse.fromJson(response.data);
      } else {
        log("ERROR API: ${response.data['message']}");
        throw Exception();
      }
    } on DioException catch (e) {
      log("DIO ERROR: $e");
      res = ObjectDetectedResponse.defaultResponse();
    } catch (e) {
      log("ERROR: $e");
      res = ObjectDetectedResponse.defaultResponse();
    }
    return res;
  }
}
