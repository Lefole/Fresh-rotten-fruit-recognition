import 'package:flutter/material.dart';

import 'package:rotten_fruit_recognition/app/app.dart';
import 'package:rotten_fruit_recognition/app/dependendy_injection.dart';

void main() {
  injectDependencies();
  runApp(const MyApp());
}
