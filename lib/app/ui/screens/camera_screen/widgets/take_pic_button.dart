import 'package:flutter/material.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_configuration_controller.dart';

class TakePictureButton extends StatelessWidget {
  final CameraConfigurationController controller;

  const TakePictureButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        controller.takePictureAndNavigate();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            color: Colors.white,
            width: 3,
          ),
        ),
        child: Center(
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
