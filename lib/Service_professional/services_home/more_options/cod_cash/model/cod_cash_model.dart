// To parse this JSON data, do
//
//     final codCashModel = codCashModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CodCashModel codCashModelFromJson(String str) =>
    CodCashModel.fromJson(json.decode(str));

String codCashModelToJson(CodCashModel data) => json.encode(data.toJson());

class CodCashModel {
  String id;
  String orderId;
  String price;
  String createdAt;
  String customerName;

  CodCashModel({
    required this.id,
    required this.orderId,
    required this.price,
    required this.createdAt,
    required this.customerName,
  });

  factory CodCashModel.fromJson(Map<String, dynamic> json) => CodCashModel(
        id: json["id"].toString(),
        orderId: json["order_id"].toString(),
        price: json["price"].toString(),
        createdAt: json["created_at"].toString(),
        customerName: json["customer_name"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "price": price,
        "created_at": createdAt,
        "customer_name": customerName,
      };
}
