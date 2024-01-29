import 'package:dio/dio.dart';
import 'package:get/get.dart';

void injectDependencies() {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.24.164.121:5050/api/v1/',
    ),
  );

  Get.lazyPut<Dio>(() => dio);
}
