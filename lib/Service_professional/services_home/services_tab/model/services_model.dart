// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServicesModel servicesModelFromJson(String str) =>
    ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

class ServicesModel {
  String categoryId;
  String categoryName;
  List<Datum> data;

  ServicesModel({
    required this.categoryId,
    required this.categoryName,
    required this.data,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String title;
  int status;

  Datum({
    required this.id,
    required this.title,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
      };
}
