import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

void injectDependencies() {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.17:5050/api/v1/',
    ),
  );

  Get.lazyPut<Dio>(() => dio);
  //Get.put(PictureScreenController());
  //Get.put(SplashScreenController());
}
