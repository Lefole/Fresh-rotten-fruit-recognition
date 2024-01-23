import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/camera_screen.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/picture_screen.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        'pictureScreen': (_) => const PictureScreen(),
        'cameraScreen': (_) => const CameraScreen()
      },
      home: const SplashScreen(),
    );
  }
}
