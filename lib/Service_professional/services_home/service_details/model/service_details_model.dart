// To parse this JSON data, do
//
//     final serviceDetailsModel = serviceDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ServiceDetailsModel serviceDetailsModelFromJson(String str) =>
    ServiceDetailsModel.fromJson(json.decode(str));

String serviceDetailsModelToJson(ServiceDetailsModel data) =>
    json.encode(data.toJson());

class ServiceDetailsModel {
  String orderId;
  String is_rescheduled;
  String is_pay_after_service;
  String id;
  String sessionId;
  String subTotal;
  String grandTotal;
  String serviceDate;
  String serviceTime;
  String customerName;
  String customerMobile;
  String customerAddress;
  String customerLandmark;
  String customerDoorNo;
  String earnings;
  String completedDate;
  String complaint;
  String service_name;
  String quotationDate;
  String tip;
  String taxAmount;
  String createdAt;
  String couponcode;
  String couponDiscount;
  String paymentMode;
  String paymentType;
  String custLatitude;
  String custLongitude;
  String isQuote;
  String? device_brand;
  String? model_name;
  String? serial_number;
  String? is_vendor_update_device_details;
  String? device_model_name;
  String? device_type;
  String? is_amc_subscription;
  String? device_id;
  String status;
  List<ServiceItem> serviceItems;
  String extraQuotationPrice;
  List<VisitAndQuote> visitAndQuote;
  String visitAndQuotePrice;
  List<Tax> taxes;

  ServiceDetailsModel({
    required this.orderId,
    required this.device_id,
    required this.id,
    required this.sessionId,
    required this.device_brand,
    required this.complaint,
    required this.device_type,
    required this.service_name,
    required this.model_name,
    required this.serial_number,
    required this.device_model_name,
    required this.is_amc_subscription,
    required this.is_vendor_update_device_details,
    required this.subTotal,
    this.is_rescheduled = '',
    this.is_pay_after_service = '',
    required this.grandTotal,
    required this.serviceDate,
    required this.quotationDate,
    required this.completedDate,
    required this.serviceTime,
    required this.earnings,
    required this.customerName,
    required this.customerMobile,
    required this.customerAddress,
    required this.customerLandmark,
    required this.paymentMode,
    required this.paymentType,
    required this.custLatitude,
    required this.custLongitude,
    required this.customerDoorNo,
    required this.tip,
    required this.taxAmount,
    required this.createdAt,
    required this.couponcode,
    required this.couponDiscount,
    required this.isQuote,
    required this.status,
    required this.serviceItems,
    required this.extraQuotationPrice,
    required this.visitAndQuote,
    required this.visitAndQuotePrice,
    required this.taxes,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) =>
      ServiceDetailsModel(
        orderId: json["order_id"],
        complaint: json["complaint"],
        is_vendor_update_device_details: json["is_vendor_update_device_details"],
        device_type: json["device_type"],
        device_id: json["device_id"],
        serial_number: json["serial_number"],
        is_amc_subscription: json["is_amc_subscription"],
        model_name: json["model_name"],
        device_model_name: json["device_model_name"],
        device_brand: json["device_brand"],
        id: json["id"],
        sessionId: json["session_id"],
        is_pay_after_service: json["is_pay_after_service"],
        subTotal: json["sub_total"],
        quotationDate: json["quotation_date"],
        earnings: json["earnings"],
        is_rescheduled: json["is_rescheduled"],
        grandTotal: json["grand_total_amount"].toString(),
        serviceDate: json["service_date"],
        completedDate: json["completed_date"],
        serviceTime: json["service_time"],
        customerName: json["customer_name"],
        customerMobile: json["customer_mobile"],
        customerAddress: json["customer_address"],
        customerLandmark: json["customer_landmark"],
        customerDoorNo: json["customer_door_no"],
        tip: json["tip"],
        taxAmount: json["tax_amount"],
        createdAt: json["created_at"],
        couponcode: json["couponcode"],
        couponDiscount: json["coupon_discount"],
        paymentMode: json["payment_mode"],
        paymentType: json["payment_type"],
        custLatitude: json["cust_latitude"],
        custLongitude: json["cust_longitude"],
        isQuote: json["isQuote"],
        service_name: json["service_name"] ??'',
        status: json["status"],
        serviceItems: List<ServiceItem>.from(
            json["service_items"].map((x) => ServiceItem.fromJson(x))),
        extraQuotationPrice: json["extra_quotation_price"].toString(),
        visitAndQuote: List<VisitAndQuote>.from(
            json["visit_and_quote"].map((x) => VisitAndQuote.fromJson(x))),
        visitAndQuotePrice: json["visit_and_quote_price"].toString(),
        taxes: List<Tax>.from(json["taxes"].map((x) => Tax.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "id": id,
        "session_id": sessionId,
        "is_vendor_update_device_details": is_vendor_update_device_details,
        "quotation_date": quotationDate,
        "sub_total": subTotal,
        "earnings": earnings,
        "grand_total": grandTotal,
        "service_name": service_name,
        "service_date": serviceDate,
        "device_type": device_type,
        "completed_date": completedDate,
        "is_rescheduled": is_rescheduled,
        "device_model_name": device_model_name,
        "service_time": serviceTime,
        "is_pay_after_service": is_pay_after_service,
        "customer_name": customerName,
        "customer_mobile": customerMobile,
        "customer_address": customerAddress,
        "customer_landmark": customerLandmark,
        "customer_door_no": customerDoorNo,
        "tip": tip,
        "tax_amount": taxAmount,
        "created_at": createdAt,
        "couponcode": couponcode,
        "coupon_discount": couponDiscount,
        "payment_mode": paymentMode,
        "payment_type": paymentType,
        "cust_latitude": custLatitude,
        "cust_longitude": custLongitude,
        "isQuote": isQuote,
        "status": status,
        "service_items":
            List<dynamic>.from(serviceItems.map((x) => x.toJson())),
        "extra_quotation_price": extraQuotationPrice,
        "visit_and_quote":
            List<dynamic>.from(visitAndQuote.map((x) => x.toJson())),
        "visit_and_quote_price": visitAndQuotePrice,
        "taxes": List<dynamic>.from(taxes.map((x) => x.toJson())),
      };
}

class ServiceItem {
  String id;
  String serviceName;
  String quantity;
  String price;
  String unitPrice;
  String hasVisitAndQuote;

  ServiceItem({
    required this.id,
    required this.serviceName,
    required this.quantity,
    required this.price,
    required this.unitPrice,
    required this.hasVisitAndQuote,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) => ServiceItem(
        id: json["id"],
        serviceName: json["service_name"],
        quantity: json["quantity"],
        price: json["price"],
        unitPrice: json["unit_price"],
        hasVisitAndQuote: json["has_visit_and_quote"],
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

class Tax {
  String id;
  String taxName;
  String taxType;
  String taxAmount;

  Tax({
    required this.id,
    required this.taxName,
    required this.taxType,
    required this.taxAmount,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        taxName: json["tax_name"],
        taxType: json["tax_type"],
        taxAmount: json["total_price"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tax_name": taxName,
        "tax_type": taxType,
        "tax_amount": taxAmount,
      };
}
class VisitAndQuote {
  String id;
  String serviceName;
  String price;
  String serialNumber;
  String warrantyDays;

  VisitAndQuote({
    required this.id,
    required this.serviceName,
    required this.price,
    required this.serialNumber,
    required this.warrantyDays,
  });

  factory VisitAndQuote.fromJson(Map<String, dynamic> json) => VisitAndQuote(
    id: json["id"],
    serviceName: json["service_name"],
    price: json["price"],
    serialNumber: json["serial_number"] ?? '',
    warrantyDays: json["warrenty_days"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_name": serviceName,
    "price": price,
    "serial_number": serialNumber,
    "warrenty_days": warrantyDays,
  };
}
