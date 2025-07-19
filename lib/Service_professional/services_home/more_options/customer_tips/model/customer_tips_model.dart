// To parse this JSON data, do
//
//     final tipsListModel = tipsListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TipsListModel tipsListModelFromJson(String str) =>
    TipsListModel.fromJson(json.decode(str));

String tipsListModelToJson(TipsListModel data) => json.encode(data.toJson());

class TipsListModel {
  String id;
  String sessionId;
  String customerName;
  String tip;
  String createdAt;

  TipsListModel({
    required this.id,
    required this.sessionId,
    required this.customerName,
    required this.tip,
    required this.createdAt,
  });

  factory TipsListModel.fromJson(Map<String, dynamic> json) => TipsListModel(
        id: json["id"].toString(),
        sessionId: json["session_id"].toString(),
        customerName: json["customer_name"].toString(),
        tip: json["tip"].toString(),
        createdAt: json["created_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
        "customer_name": customerName,
        "tip": tip,
        "created_at": createdAt,
      };
}
