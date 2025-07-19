// To parse this JSON data, do
//
//     final payoutsDetailsModel = payoutsDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PayoutsDetailsModel payoutsDetailsModelFromJson(String str) =>
    PayoutsDetailsModel.fromJson(json.decode(str));

String payoutsDetailsModelToJson(PayoutsDetailsModel data) =>
    json.encode(data.toJson());

class PayoutsDetailsModel {
  String id;
  String orderIds;
  String restaurantId;
  String settlementAttachment;
  String settlementRefId;
  String settledAmount;
  String settlementRemarks;
  String accountName;
  String accountNumber;
  String bankName;
  String branch;
  String ifscCode;
  String settledDate;
  String seenStatus;

  PayoutsDetailsModel({
    required this.id,
    required this.orderIds,
    required this.restaurantId,
    required this.settlementAttachment,
    required this.settlementRefId,
    required this.settledAmount,
    required this.settlementRemarks,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.branch,
    required this.ifscCode,
    required this.settledDate,
    required this.seenStatus,
  });

  factory PayoutsDetailsModel.fromJson(Map<String, dynamic> json) =>
      PayoutsDetailsModel(
        id: json["id"],
        orderIds: json["order_ids"],
        restaurantId: json["restaurant_id"],
        settlementAttachment: json["settlement_attachment"],
        settlementRefId: json["settlement_ref_id"],
        settledAmount: json["settled_amount"],
        settlementRemarks: json["settlement_remarks"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        branch: json["branch"],
        ifscCode: json["ifsc_code"],
        settledDate: json["settled_date"],
        seenStatus: json["seen_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_ids": orderIds,
        "restaurant_id": restaurantId,
        "settlement_attachment": settlementAttachment,
        "settlement_ref_id": settlementRefId,
        "settled_amount": settledAmount,
        "settlement_remarks": settlementRemarks,
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "branch": branch,
        "ifsc_code": ifscCode,
        "settled_date": settledDate,
        "seen_status": seenStatus,
      };
}
