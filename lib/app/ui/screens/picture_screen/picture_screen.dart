import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/controllers/picture_screen_controller.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/widgets/description_widget.dart';
import 'package:rotten_fruit_recognition/app/ui/screens/picture_screen/widgets/results_widget.dart';

class PictureScreen extends StatelessWidget {
  const PictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          "Estado fruta",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: GetBuilder<PictureScreenController>(
          builder: (controller) => Column(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: (controller.imageFilePath != "")
                    ? Image.file(File(controller.imageFilePath))
                    : const SizedBox(),
              ),
              ListTile(
                title: Text("Fruta: ${controller.fruitName}"),
                subtitle: Text("Estado: ${controller.state}"),
                trailing: (controller.state == "Podrida")
                    ? const Icon(
                        Icons.check_circle_outline_outlined,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.dangerous_outlined,
                        color: Colors.red,
                      ),
                titleTextStyle:
                    const TextStyle(fontSize: 20, color: Colors.black),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: const Column(
                        children: [
                          DescriptionWidget(),
                          SizedBox(
                            height: 40,
                          ),
                          ResultsWidget(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
