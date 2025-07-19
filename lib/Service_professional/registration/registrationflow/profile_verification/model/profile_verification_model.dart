// To parse this JSON data, do
//
//     final profileVerficationModel = profileVerficationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileVerficationModel profileVerficationModelFromJson(String str) =>
    ProfileVerficationModel.fromJson(json.decode(str));

String profileVerficationModelToJson(ProfileVerficationModel data) =>
    json.encode(data.toJson());

class ProfileVerficationModel {
  String kycStatus;
  String vendorStatus;
  bool bankDetails;
  bool displayImage;

  ProfileVerficationModel({
    required this.kycStatus,
    required this.vendorStatus,
    required this.bankDetails,
    required this.displayImage,
  });

  factory ProfileVerficationModel.fromJson(Map<String, dynamic> json) =>
      ProfileVerficationModel(
        kycStatus: json['kyc_status'].toString(),
        vendorStatus: json["vendor_status"].toString(),
        bankDetails: json["bank_details"],
        displayImage: json["display_image"],
      );

  Map<String, dynamic> toJson() => {
        'kyc_status': kycStatus,
        "vendor_status": vendorStatus,
        "bank_details": bankDetails,
        "display_image": displayImage,
      };
}
