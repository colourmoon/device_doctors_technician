// To parse this JSON data, do
//
//     final referListModel = referListModelFromJson(jsonString);

import 'dart:convert';

ReferListModel referListModelFromJson(String str) =>
    ReferListModel.fromJson(json.decode(str));

String referListModelToJson(ReferListModel data) => json.encode(data.toJson());

class ReferListModel {
  String errCode;
  String referedAmount;
  List<ReferList> data;

  ReferListModel({
    required this.errCode,
    required this.referedAmount,
    required this.data,
  });

  factory ReferListModel.fromJson(Map<String, dynamic> json) => ReferListModel(
        errCode: json["err_code"],
        referedAmount: json["refered_amount"],
        data: List<ReferList>.from(
            json["data"].map((x) => ReferList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "refered_amount": referedAmount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ReferList {
  String id;
  String vendorId;
  String mobile;
  String name;
  String age;
  String service;
  String referAmount;
  String createdAt;
  String status;

  ReferList({
    required this.id,
    required this.vendorId,
    required this.mobile,
    required this.name,
    required this.age,
    required this.service,
    required this.referAmount,
    required this.createdAt,
    required this.status,
  });

  factory ReferList.fromJson(Map<String, dynamic> json) => ReferList(
        id: json["id"],
        vendorId: json["vendor_id"],
        mobile: json["mobile"],
        name: json["name"],
        age: json["age"],
        service: json["service"],
        referAmount: json["refer_amount"],
        createdAt: json["created_at"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "mobile": mobile,
        "name": name,
        "age": age,
        "service": service,
        "refer_amount": referAmount,
        "created_at": createdAt,
        "status": status,
      };
}
