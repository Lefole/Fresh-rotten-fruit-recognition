import 'package:flutter/material.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/camera_screen/controllers/camera_capture_controller.dart';

class TakePictureButton extends StatelessWidget {
  final CameraCaptureController captureController;
  final bool isCameraInitialized;

  const TakePictureButton({
    Key? key,
    required this.captureController,
    required this.isCameraInitialized,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picture = await captureController.takePicture();
        final jpegPicturePath =
            await captureController.savePictureAsJPG(picture);
        await Future.delayed(
            const Duration(milliseconds: 1),
            () => captureController.navigateToPictureScreen(
                context, jpegPicturePath));
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
