// To parse this JSON data, do
//
//     final payoutListModel = payoutListModelFromJson(jsonString);

import 'dart:convert';

PayoutListModel payoutListModelFromJson(String str) =>
    PayoutListModel.fromJson(json.decode(str));

String payoutListModelToJson(PayoutListModel data) =>
    json.encode(data.toJson());

class PayoutListModel {
  String errCode;
  List<PayoutList> data;

  PayoutListModel({
    required this.errCode,
    required this.data,
  });

  factory PayoutListModel.fromJson(Map<String, dynamic> json) =>
      PayoutListModel(
        errCode: json["err_code"],
        data: List<PayoutList>.from(
            json["data"].map((x) => PayoutList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PayoutList {
  String id;
  String sessionId;
  String status;
  String subTotal;
  DateTime serviceDate;
  String createdAt;

  PayoutList({
    required this.id,
    required this.sessionId,
    required this.status,
    required this.subTotal,
    required this.serviceDate,
    required this.createdAt,
  });

  factory PayoutList.fromJson(Map<String, dynamic> json) => PayoutList(
        id: json["id"],
        sessionId: json["session_id"],
        status: json["status"],
        subTotal: json["sub_total"],
        serviceDate: DateTime.parse(json["service_date"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
        "status": status,
        "sub_total": subTotal,
        "service_date":
            "${serviceDate.year.toString().padLeft(4, '0')}-${serviceDate.month.toString().padLeft(2, '0')}-${serviceDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
      };
}
