// To parse this JSON data, do
//
//     final helpSupportListModel = helpSupportListModelFromJson(jsonString);

import 'dart:convert';

HelpSupportListModel helpSupportListModelFromJson(String str) =>
    HelpSupportListModel.fromJson(json.decode(str));

String helpSupportListModelToJson(HelpSupportListModel data) =>
    json.encode(data.toJson());

class HelpSupportListModel {
  String errCode;
  List<HelpSupportList> data;

  HelpSupportListModel({
    required this.errCode,
    required this.data,
  });

  factory HelpSupportListModel.fromJson(Map<String, dynamic> json) =>
      HelpSupportListModel(
        errCode: json["err_code"],
        data: List<HelpSupportList>.from(
            json["data"].map((x) => HelpSupportList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class HelpSupportList {
  String id;
  String vendorId;
  String type;
  String issue;
  String orderId;
  String image;
  String createdAt;

  HelpSupportList({
    required this.id,
    required this.vendorId,
    required this.type,
    required this.issue,
    required this.orderId,
    required this.image,
    required this.createdAt,
  });

  factory HelpSupportList.fromJson(Map<String, dynamic> json) =>
      HelpSupportList(
        id: json["id"],
        vendorId: json["vendor_id"],
        type: json["type"],
        issue: json["issue"],
        orderId: json["order_id"],
        image: json["image"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "type": type,
        "issue": issue,
        "order_id": orderId,
        "image": image,
        "created_at": createdAt,
      };
}
