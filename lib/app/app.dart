import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      initialRoute: "/splash_screen",
      getPages: [
        GetPage(name: "/splash_screen", page: () => const SplashScreen()),
        GetPage(name: "/camera_screen", page: () => const CameraScreen()),
        GetPage(name: "/picture_screen", page: () => const PictureScreen()),
      ],
      home: const SplashScreen(),
    );
  }
}
