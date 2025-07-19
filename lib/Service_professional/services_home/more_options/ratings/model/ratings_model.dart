// To parse this JSON data, do
//
//     final ratingReviewsModel = ratingReviewsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RatingReviewsModel ratingReviewsModelFromJson(String str) =>
    RatingReviewsModel.fromJson(json.decode(str));

String ratingReviewsModelToJson(RatingReviewsModel data) =>
    json.encode(data.toJson());

class RatingReviewsModel {
  String id;
  String customersId;
  String orderId;
  String review;
  String rating;
  String vendorId;
  String createdAt;
  int reviewCount;
  String customerName;
  String image;

  RatingReviewsModel({
    required this.id,
    required this.customersId,
    required this.orderId,
    required this.review,
    required this.rating,
    required this.vendorId,
    required this.createdAt,
    required this.reviewCount,
    required this.customerName,
    required this.image,
  });

  factory RatingReviewsModel.fromJson(Map<String, dynamic> json) =>
      RatingReviewsModel(
        id: json["id"],
        customersId: json["customers_id"],
        orderId: json["order_id"],
        review: json["review"],
        rating: json["rating"],
        vendorId: json["vendor_id"],
        createdAt: json["created_at"],
        reviewCount: json["review_count"],
        customerName: json["customer_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customers_id": customersId,
        "order_id": orderId,
        "review": review,
        "rating": rating,
        "vendor_id": vendorId,
        "created_at": createdAt,
        "review_count": reviewCount,
        "customer_name": customerName,
        "image": image,
      };
}
