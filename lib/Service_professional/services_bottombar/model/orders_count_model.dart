// To parse this JSON data, do
//
//     final ordersCountModel = ordersCountModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrdersCountModel ordersCountModelFromJson(String str) =>
    OrdersCountModel.fromJson(json.decode(str));

String ordersCountModelToJson(OrdersCountModel data) =>
    json.encode(data.toJson());

class OrdersCountModel {
  dynamic newOrders;
  dynamic acceptedOrders;
  dynamic ongoingOrders;

  OrdersCountModel({
    required this.newOrders,
    required this.acceptedOrders,
    required this.ongoingOrders,
  });

  factory OrdersCountModel.fromJson(Map<String, dynamic> json) =>
      OrdersCountModel(
        newOrders: json["new_orders"] ?? 0,
        acceptedOrders: json["accepted_orders"] ?? 0,
        ongoingOrders: json["ongoing_orders"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "new_orders": newOrders,
        "accepted_orders": acceptedOrders,
        "ongoing_orders": ongoingOrders,
      };
}
