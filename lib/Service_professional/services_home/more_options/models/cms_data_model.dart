// To parse this JSON data, do
//
//     final cmsDataModel = cmsDataModelFromJson(jsonString);

import 'dart:convert';

CmsDataModel cmsDataModelFromJson(String str) =>
    CmsDataModel.fromJson(json.decode(str));

String cmsDataModelToJson(CmsDataModel data) => json.encode(data.toJson());

class CmsDataModel {
  String errCode;
  CmsData data;

  CmsDataModel({
    required this.errCode,
    required this.data,
  });

  factory CmsDataModel.fromJson(Map<String, dynamic> json) => CmsDataModel(
        errCode: json["err_code"],
        data: CmsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "err_code": errCode,
        "data": data.toJson(),
      };
}

class CmsData {
  String id;
  String name;
  String description;

  CmsData({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CmsData.fromJson(Map<String, dynamic> json) => CmsData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
