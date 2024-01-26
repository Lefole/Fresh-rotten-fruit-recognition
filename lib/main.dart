import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/app.dart';
import 'package:rotten_fruit_recognition/app/dependendy_injection.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/controllers/picture_screen_controller.dart';

void main() {
  injectDependencies();
  runApp(const MyApp());
}
