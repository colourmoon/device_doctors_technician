import '../../../../commons/pagination_model/pagination_model.dart';

class PayoutsListModel {
  final List<OrderData> results;
  PaginationTestModel paginationTestModel;

  PayoutsListModel({
    required this.results,
    required this.paginationTestModel,
  });

  factory PayoutsListModel.emptyModel() => PayoutsListModel(
      results: [], paginationTestModel: PaginationTestModel.initial());
  factory PayoutsListModel.fromJson(Map<String, dynamic> json) =>
      PayoutsListModel(
        results: List<OrderData>.from(
            json["results"].map((x) => OrderData.fromJson(x))),
        paginationTestModel: PaginationTestModel.fromMap(json),
      );

  //Use for pagination
  PayoutsListModel paginationCopyWith({required PayoutsListModel newData}) {
    results.addAll(newData.results);
    paginationTestModel = newData.paginationTestModel;
    return PayoutsListModel(
        results: results, paginationTestModel: paginationTestModel);
  }
}

// To parse this JSON data, do
//
//     final orderData = orderDataFromJson(jsonString);

class OrderData {
  String id;
  String sessionId;
  String status;
  String subTotal;
  String earnings;
  DateTime serviceDate;
  String createdAt;

  OrderData({
    required this.id,
    required this.sessionId,
    required this.status,
    required this.subTotal,
    required this.earnings,
    required this.serviceDate,
    required this.createdAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        sessionId: json["session_id"],
        status: json["status"],
        earnings: json["earnings"],
        subTotal: json["sub_total"],
        serviceDate: DateTime.parse(json["service_date"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
        "status": status,
        "earnings": earnings,
        "sub_total": subTotal,
        "service_date":
            "${serviceDate.year.toString().padLeft(4, '0')}-${serviceDate.month.toString().padLeft(2, '0')}-${serviceDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
      };
}
