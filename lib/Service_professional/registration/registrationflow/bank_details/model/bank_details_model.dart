// To parse this JSON data, do
//
//     final bankDetailsModel = bankDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BankDetailsModel bankDetailsModelFromJson(String str) =>
    BankDetailsModel.fromJson(json.decode(str));

String bankDetailsModelToJson(BankDetailsModel data) =>
    json.encode(data.toJson());

class BankDetailsModel {
  String id;
  String accountName;
  String accountNumber;
  String bankName;
  String branch;
  String ifscCode;
  String createdAt;

  BankDetailsModel({
    required this.id,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.branch,
    required this.ifscCode,
    required this.createdAt,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) =>
      BankDetailsModel(
        id: json["id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bankName: json["bank_name"],
        branch: json["branch"],
        ifscCode: json["ifsc_code"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_name": accountName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "branch": branch,
        "ifsc_code": ifscCode,
        "created_at": createdAt,
      };
}
