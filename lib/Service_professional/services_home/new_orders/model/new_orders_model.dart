// To parse this JSON data, do
//
//     final newOrderModel = newOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewOrderModel newOrderModelFromJson(String str) =>
    NewOrderModel.fromJson(json.decode(str));

String newOrderModelToJson(NewOrderModel data) => json.encode(data.toJson());

class NewOrderModel {
  String status;
  String orderId;
  String id;
  bool orderhasvisitAndQuote;
  String sessionId;
  String grandTotal;
  String serviceDate;
  String serviceTime;
  String isQuote;
  String customerName;
  String customerMobile;
  String paymentMode;
  String paymentType;
  String device_details_updated;
  String device_brand;
  String model_name;
  String serial_number;
  String is_amc_subscription;
  String custLatitude;
  String custLongitude;
  String completedDate;
  CustomerRatingObj? customerRatingObj;
  bool isRating;
  List<VisitAndQuote> visitAndQuote;
  String visitAndQuotePrice;
  List<ServiceItem> serviceItems;
  String extraQuotationPrice;
  String earnings;

  NewOrderModel(
      {required this.status,
      required this.orderId,
      required this.id,
      required this.device_brand,
      required this.model_name,
      required this.serial_number,
      this.orderhasvisitAndQuote = false,
      required this.sessionId,
      required this.grandTotal,
      required this.serviceDate,
      required this.serviceTime,
      required this.isQuote,
      required this.customerName,
      required this.is_amc_subscription,
      required this.customerMobile,
      required this.paymentMode,
      required this.paymentType,
      required this.completedDate,
      required this.customerRatingObj,
      required this.custLatitude,
      required this.device_details_updated,
      required this.custLongitude,
      required this.isRating,
      required this.visitAndQuote,
      required this.visitAndQuotePrice,
      required this.serviceItems,
      required this.extraQuotationPrice,
      required this.earnings});

  factory NewOrderModel.fromJson(Map<String, dynamic> json) => NewOrderModel(
      status: json["status"].toString(),
      orderId: json["order_id"],
      id: json["id"],
      sessionId: json["session_id"],
      grandTotal: json["grand_total"].toString(),
      serviceDate: json["service_date"].toString(),
      device_brand: json["device_brand"].toString(),
      model_name: json["model_name"].toString(),
      serial_number: json["serial_number"].toString(),
      serviceTime: json["service_time"].toString(),
      isQuote: json["isQuote"].toString(),
      completedDate: json["completed_date"].toString(),
      customerName: json["customer_name"] ?? "",
      device_details_updated: json["device_details_updated"] ?? "",
      customerMobile: json["customer_mobile"] ?? "",
      is_amc_subscription: json["is_amc_subscription"] ?? "",
      paymentMode: json["payment_mode"] ?? "",
      paymentType: json["payment_type"] ?? "",
      custLatitude: json["cust_latitude"] ?? "",
      custLongitude: json["cust_longitude"] ?? "",
      customerRatingObj: json["customer_rating_obj"] == ""
          ? null
          : CustomerRatingObj.fromJson(json["customer_rating_obj"]),
      isRating: json["isRating"],
      visitAndQuote: List<VisitAndQuote>.from(
          json["visit_and_quote"].map((x) => VisitAndQuote.fromJson(x))),
      visitAndQuotePrice: json["visit_and_quote_price"].toString(),
      serviceItems: List<ServiceItem>.from(
          json["service_items"].map((x) => ServiceItem.fromJson(x))),
      extraQuotationPrice: json["extra_quotation_price"].toString(),
      earnings: json["earnings"].toString());

  Map<String, dynamic> toJson() => {
        "status": status,
        "order_id": orderId,
        "id": id,
        "session_id": sessionId,
        "is_amc_subscription": is_amc_subscription,
        "grand_total": grandTotal,
        "service_date": serviceDate,
        "service_time": serviceTime,
        "device_details_updated": device_details_updated,
        "device_brand": device_brand,
        "model_name": model_name,
        "serial_number": serial_number,
        "isQuote": isQuote,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "completed_date": completedDate,
        "customer_rating_obj": customerRatingObj,
        "payment_mode": paymentMode,
        "payment_type": paymentType,
        "isRating": isRating,
        "cust_latitude": custLatitude,
        "cust_longitude": custLongitude,
        "visit_and_quote":
            List<dynamic>.from(visitAndQuote.map((x) => x.toJson())),
        "visit_and_quote_price": visitAndQuotePrice,
        "service_items":
            List<dynamic>.from(serviceItems.map((x) => x.toJson())),
        "extra_quotation_price": extraQuotationPrice,
        "earnings": earnings
      };
}

class CustomerRatingObj {
  String customerName;
  String image;
  String review;
  String rating;

  CustomerRatingObj({
    required this.customerName,
    required this.image,
    required this.review,
    required this.rating,
  });

  factory CustomerRatingObj.fromJson(Map<String, dynamic> json) =>
      CustomerRatingObj(
        customerName: json["customer_name"],
        image: json["image"],
        review: json["review"].toString(),
        rating: json["rating"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "image": image,
        "review": review,
        "rating": rating,
      };
}

class ServiceItem {
  final String id;
  final String? serviceName;
  final String quantity;
  final String price;
  final String unitPrice;
  final String hasVisitAndQuote;

  ServiceItem({
    required this.id,
    this.serviceName,
    required this.quantity,
    required this.price,
    required this.unitPrice,
    required this.hasVisitAndQuote,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
        id: json["id"]?.toString() ?? '',
        serviceName: json["service_name"]?.toString(),
        quantity: json["quantity"]?.toString() ?? '0',
        price: json["price"]?.toString() ?? '0',
        unitPrice: json["unit_price"]?.toString() ?? '0',
        hasVisitAndQuote: json["has_visit_and_quote"]?.toString() ?? 'no',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "quantity": quantity,
        "price": price,
        "unit_price": unitPrice,
        "has_visit_and_quote": hasVisitAndQuote,
      };
}

class VisitAndQuote {
  String id;
  String serviceName;
  String price;

  VisitAndQuote({
    required this.id,
    required this.serviceName,
    required this.price,
  });

  factory VisitAndQuote.fromJson(Map<String, dynamic> json) => VisitAndQuote(
        id: json["id"],
        serviceName: json["service_name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "price": price,
      };
}
