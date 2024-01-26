import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/controllers/picture_screen_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/splash_screen/controller/splash_screen_controller.dart';

void injectDependencies() {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.5:5050/api/v1/',
    ),
  );

  Get.lazyPut<Dio>(() => dio);
  //Get.put(PictureScreenController());
  //Get.put(SplashScreenController());
}
