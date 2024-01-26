import 'dart:convert';

ObjectDetectedResponse objectDetectedResponseFromJson(String str) =>
    ObjectDetectedResponse.fromJson(json.decode(str));

String objectDetectedResponseToJson(ObjectDetectedResponse data) =>
    json.encode(data.toJson());

class ObjectDetectedResponse {
  String label;
  double confidence;
  double x;
  double y;
  double h;
  double w;

  ObjectDetectedResponse({
    required this.label,
    required this.confidence,
    required this.x,
    required this.y,
    required this.h,
    required this.w,
  });

  factory ObjectDetectedResponse.defaultResponse() => ObjectDetectedResponse(
        label: "",
        confidence: 0.0,
        x: 0.0,
        y: 0.0,
        h: 0.0,
        w: 0.0,
      );

  factory ObjectDetectedResponse.fromJson(Map<String, dynamic> json) =>
      ObjectDetectedResponse(
        label: json["label"],
        confidence: json["confidence"]?.toDouble(),
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        h: json["h"]?.toDouble(),
        w: json["w"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "confidence": confidence,
        "x": x,
        "y": y,
        "h": h,
        "w": w,
      };
}
