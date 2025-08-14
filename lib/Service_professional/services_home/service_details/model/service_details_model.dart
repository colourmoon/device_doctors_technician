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

  BillDetails? billDetails;
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
  String? sub_total;
  String? booking_payment_status;
  String? taxPercentage;
  String? wallet_part_payment;
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
    required this.wallet_part_payment,
    required this.complaint,
    required this.device_type,
    required this.service_name,
    required this.model_name,
    required this.serial_number,
    required this.device_model_name,
    required this.taxPercentage,
    required this.is_amc_subscription,
    required this.is_vendor_update_device_details,
    required this.subTotal,
    this.is_rescheduled = '',
    this.booking_payment_status = '',
    this.is_pay_after_service = '',
    required this.grandTotal,
    required this.serviceDate,
    required this.quotationDate,
    required this.completedDate,
    required this.serviceTime,
    required this.billDetails,
    required this.sub_total,
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
        taxPercentage: json["tax_percentage"],
        complaint: json["complaint"],
        is_vendor_update_device_details:
            json["is_vendor_update_device_details"],
        device_type: json["device_type"],
        device_id: json["device_id"],
        booking_payment_status: json["booking_payment_status"],
        wallet_part_payment: json["wallet_part_payment"],
        billDetails: json['bill_details'] != null
            ? new BillDetails.fromJson(json['bill_details'])
            : null,
        serial_number: json["serial_number"],
        is_amc_subscription: json["is_amc_subscription"],
        model_name: json["model_name"],
        sub_total: json["sub_total"],
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
        service_name: json["service_name"] ?? '',
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
        "booking_payment_status": booking_payment_status,

        "tax_percentage": taxPercentage,
        "sub_total": sub_total,
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
        "wallet_part_payment": wallet_part_payment,
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
        'bill_details': billDetails?.toJson(),
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
  String totalPrice;
  String taxType;
  String taxAmount;
  String tax_percentage;

  Tax({
    required this.id,
    required this.taxName,
    required this.taxType,
    required this.totalPrice,
    this.tax_percentage = '',
    required this.taxAmount,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        taxName: json["tax_name"],
        taxType: json["tax_type"],
        totalPrice: json["total_price"],
        tax_percentage: json["tax_percentage"] ?? "",
        taxAmount: json["total_price"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tax_name": taxName,
        "tax_type": taxType,
        "tax_percentage": tax_percentage,
        "total_price": taxAmount,
      };
}

class VisitAndQuote {
  String id;
  String serviceName;
  String price;
  String sub_total;
  String tax_amount;
  String serialNumber;
  String warrantyDays;

  VisitAndQuote({
    required this.id,
    required this.serviceName,
    required this.price,
    required this.tax_amount,
    required this.sub_total,
    required this.serialNumber,
    required this.warrantyDays,
  });

  factory VisitAndQuote.fromJson(Map<String, dynamic> json) => VisitAndQuote(
        id: json["id"],
        serviceName: json["service_name"],
        price: json["price"],
    tax_amount: json["tax_amount"],
    sub_total: json["sub_total"],
        serialNumber: json["serial_number"] ?? '',
        warrantyDays: json["warrenty_days"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "service_name": serviceName,
        "tax_amount": tax_amount,
        "price": price,
        "sub_total": sub_total,
        "serial_number": serialNumber,
        "warrenty_days": warrantyDays,
      };
}

class BillDetails {
  List<VisitAndQuote>? visitAndQuote;
  String? taxPercentage;
  String? taxAmount;
  String? paidOnline;
  String? onlineAmount;
  String? paymentStatus;
  String? totalBill;

  BillDetails(
      {this.visitAndQuote,
      this.taxPercentage,
      this.taxAmount,
      this.paidOnline,
      this.onlineAmount,
      this.paymentStatus,
      this.totalBill});

  BillDetails.fromJson(Map<String, dynamic> json) {
    if (json['visit_and_quote'] != null) {
      visitAndQuote = <VisitAndQuote>[];
      json['visit_and_quote'].forEach((v) {
        visitAndQuote!.add(new VisitAndQuote.fromJson(v));
      });
    }
    taxPercentage = json['tax_percentage'];
    taxAmount = json['tax_amount'];
    paidOnline = json['paid_online'];
    onlineAmount = json['online_amount'];
    paymentStatus = json['payment_status'];
    totalBill = json['total_bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visitAndQuote != null) {
      data['visit_and_quote'] =
          this.visitAndQuote!.map((v) => v.toJson()).toList();
    }
    data['tax_percentage'] = this.taxPercentage;
    data['tax_amount'] = this.taxAmount;
    data['paid_online'] = this.paidOnline;
    data['online_amount'] = this.onlineAmount;
    data['payment_status'] = this.paymentStatus;
    data['total_bill'] = this.totalBill;
    return data;
  }
}
