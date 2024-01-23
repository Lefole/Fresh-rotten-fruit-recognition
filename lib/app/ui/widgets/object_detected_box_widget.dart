import 'package:flutter/material.dart';

class ObjectDetectedBoxWidget extends StatelessWidget {
  final String label;
  final double x;
  final double y;
  final double h;
  final double w;
  const ObjectDetectedBoxWidget({
    super.key,
    required this.x,
    required this.y,
    required this.h,
    required this.w,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: x,
      left: y,
      child: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.green),
                  color: Colors.green),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
