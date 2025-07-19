// To parse this JSON data, do
//
//     final notificationsDataNewDataModel = notificationsDataNewDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NotificationsDataNewDataModel notificationsDataNewDataModelFromJson(
        String str) =>
    NotificationsDataNewDataModel.fromJson(json.decode(str));

String notificationsDataNewDataModelToJson(
        NotificationsDataNewDataModel data) =>
    json.encode(data.toJson());

class NotificationsDataNewDataModel {
  String id;
  String createdBy;
  String userId;
  String bookingId;
  String message;
  String status;
  String viewStatus;
  String createdAt;

  NotificationsDataNewDataModel({
    required this.id,
    required this.createdBy,
    required this.userId,
    required this.bookingId,
    required this.message,
    required this.status,
    required this.viewStatus,
    required this.createdAt,
  });

  factory NotificationsDataNewDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationsDataNewDataModel(
        id: json["id"] ?? "",
        createdBy: json["created_by"] ?? "",
        userId: json["user_id"] ?? "",
        bookingId: json["booking_id"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        viewStatus: json["view_status"] ?? "",
        createdAt: json["created_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "user_id": userId,
        "booking_id": bookingId,
        "message": message,
        "status": status,
        "view_status": viewStatus,
        "created_at": createdAt,
      };
}
