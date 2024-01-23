import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class DetectedObjectScreen extends StatelessWidget {
  const DetectedObjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AAAA"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            child: Image.network(
              "https://www.google.com/search?sca_esv=416e6a74c5a20e4b&sxsrf=ACQVn09JLJoRDdPSjtTUhFt-t-A8Rid8LQ:1705978654652&q=foto+manzana&tbm=isch&source=lnms&sa=X&ved=2ahUKEwiEv9HdwfKDAxUSQTABHcj8BMoQ0pQJegQIDBAB&biw=1488&bih=708&dpr=1.25#imgrc=cktv0p37wdFAsM",
            ),
          ),
          Column(
            children: [
              ListTile(
                title: Text("Fruta en mal estado"),
                trailing: Lottie.asset(
                  "assets/lotties/fresh_fruit.json",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
