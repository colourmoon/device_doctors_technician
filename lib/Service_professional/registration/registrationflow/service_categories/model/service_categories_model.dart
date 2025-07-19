// To parse this JSON data, do
//
//     final serviceCategoriesModel = serviceCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceCategoriesModel serviceCategoriesModelFromJson(String str) =>
    ServiceCategoriesModel.fromJson(json.decode(str));

String serviceCategoriesModelToJson(ServiceCategoriesModel data) =>
    json.encode(data.toJson());

class ServiceCategoriesModel {
  String id;
  String title;
  bool isSelected;

  ServiceCategoriesModel({
    required this.id,
    required this.title,
    this.isSelected = false,
  });

  factory ServiceCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ServiceCategoriesModel(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
