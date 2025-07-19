// To parse this JSON data, do
//
//     final profileDetailsFetchingModel = profileDetailsFetchingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileDetailsFetchingModel profileDetailsFetchingModelFromJson(String str) =>
    ProfileDetailsFetchingModel.fromJson(json.decode(str));

String profileDetailsFetchingModelToJson(ProfileDetailsFetchingModel data) =>
    json.encode(data.toJson());

class ProfileDetailsFetchingModel {
  String id;
  String accessToken;
  String ownerName;
  String mobile;
  String isOnline;
  String contactEmail;
  String languageKnown;
  String gender;
  String displayImage;
  String countryName;
  String cityName;
  String services;
  String notificationCount;
  String newOrdersCount;
  String adhaarCardFront;
  String adhaarCardBack;
  String panCard;

  ProfileDetailsFetchingModel(
      {required this.id,
      required this.accessToken,
      required this.ownerName,
      required this.mobile,
      required this.isOnline,
      required this.contactEmail,
      required this.languageKnown,
      required this.gender,
      required this.displayImage,
      required this.countryName,
      required this.cityName,
      required this.services,
      required this.notificationCount,
      required this.newOrdersCount,
      required this.adhaarCardFront,
      required this.adhaarCardBack,
      required this.panCard});

  factory ProfileDetailsFetchingModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsFetchingModel(
          id: json["id"] ?? '',
          accessToken: json["access_token"] ?? '',
          ownerName: json["owner_name"] ?? '',
          mobile: json["mobile"] ?? '',
          isOnline: json["is_online"] ?? '',
          contactEmail: json["contact_email"] ?? '',
          languageKnown: json["language_known"] ?? '',
          gender: json["gender"] ?? '',
          displayImage: json["display_image"] ?? '',
          countryName: json["country_name"] ?? '',
          cityName: json["city_name"] ?? '',
          services: json["services"] ?? '',
          notificationCount: json["notification_count"] ?? '',
          newOrdersCount: json["new_orders_count"] ?? '',
          adhaarCardFront: json['adhaar_card_front'] ?? "",
          adhaarCardBack: json['adhaar_card_back'] ?? "",
          panCard: json['pan_card'] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "access_token": accessToken,
        "owner_name": ownerName,
        "mobile": mobile,
        "is_online": isOnline,
        "contact_email": contactEmail,
        "language_known": languageKnown,
        "gender": gender,
        "display_image": displayImage,
        "country_name": countryName,
        "city_name": cityName,
        "services": services,
        "notification_count": notificationCount,
        "new_orders_count": newOrdersCount,
        "adhaar_card_front": adhaarCardFront,
        "adhaar_card_back": adhaarCardBack,
        'pan_card': panCard
      };
}
