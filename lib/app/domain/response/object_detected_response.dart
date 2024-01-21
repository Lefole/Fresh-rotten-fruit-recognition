import 'dart:convert';

ObjectDetectedResponse objectDetectedResponseFromJson(String str) =>
    ObjectDetectedResponse.fromJson(json.decode(str));

String objectDetectedResponseToJson(ObjectDetectedResponse data) =>
    json.encode(data.toJson());

class ObjectDetectedResponse {
  String label;
  double x;
  double y;
  double h;
  double w;

  ObjectDetectedResponse({
    required this.label,
    required this.x,
    required this.y,
    required this.h,
    required this.w,
  });

  factory ObjectDetectedResponse.defaultResponse() => ObjectDetectedResponse(
        label: "",
        x: 0.0,
        y: 0.0,
        h: 0.0,
        w: 0.0,
      );

  factory ObjectDetectedResponse.fromJson(Map<String, dynamic> json) =>
      ObjectDetectedResponse(
        label: json["label"],
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        h: json["h"]?.toDouble(),
        w: json["w"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "x": x,
        "y": y,
        "h": h,
        "w": w,
      };
}
