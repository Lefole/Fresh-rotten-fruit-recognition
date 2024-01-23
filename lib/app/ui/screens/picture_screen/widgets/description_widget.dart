import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descripción",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Comer frutas podridas no es seguro para la salud, ya que pueden contener bacterias, mohos y toxinas que podrían causar enfermedades. Es importante desechar cualquier fruta que presente signos de descomposición, como mal olor, cambio de color, textura viscosa o presencia de moho.",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
