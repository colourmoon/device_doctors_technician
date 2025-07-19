// To parse this JSON data, do
//
//     final maintainanceModel = maintainanceModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MaintainanceModel maintainanceModelFromJson(String str) =>
    MaintainanceModel.fromJson(json.decode(str));

String maintainanceModelToJson(MaintainanceModel data) =>
    json.encode(data.toJson());

class MaintainanceModel {
  String maintenanceModeEnabled;
  String title;
  String message;
  String image;

  MaintainanceModel({
    required this.maintenanceModeEnabled,
    required this.title,
    required this.message,
    required this.image,
  });

  factory MaintainanceModel.fromJson(Map<String, dynamic> json) =>
      MaintainanceModel(
        maintenanceModeEnabled: json["maintenance_mode_enabled"] ?? "N/A",
        title: json["title"] ?? "N/A",
        message: json["message"] ?? "N/A",
        image: json["image"] ?? "N/A",
      );

  Map<String, dynamic> toJson() => {
        "maintenance_mode_enabled": maintenanceModeEnabled,
        "title": title,
        "message": message,
        "image": image,
      };
}
