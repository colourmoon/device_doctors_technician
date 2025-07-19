import '../../../../commons/pagination_model/pagination_model.dart';

class AllOrdersListModel {
  final List<OrderData> results;
  PaginationTestModel paginationTestModel;

  AllOrdersListModel({
    required this.results,
    required this.paginationTestModel,
  });

  factory AllOrdersListModel.emptyModel() => AllOrdersListModel(
      results: [], paginationTestModel: PaginationTestModel.initial());
  factory AllOrdersListModel.fromJson(Map<String, dynamic> json) =>
      AllOrdersListModel(
        results: List<OrderData>.from(
            json["results"].map((x) => OrderData.fromJson(x))),
        paginationTestModel: PaginationTestModel.fromMap(json),
      );

  //Use for pagination
  AllOrdersListModel paginationCopyWith({required AllOrdersListModel newData}) {
    results.addAll(newData.results);
    paginationTestModel = newData.paginationTestModel;
    return AllOrdersListModel(
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
  DateTime serviceDate;
  String createdAt;

  OrderData({
    required this.id,
    required this.sessionId,
    required this.status,
    required this.subTotal,
    required this.serviceDate,
    required this.createdAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        sessionId: json["session_id"],
        status: json["status"],
        subTotal: json["sub_total"],
        serviceDate: DateTime.parse(json["service_date"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "session_id": sessionId,
        "status": status,
        "sub_total": subTotal,
        "service_date":
            "${serviceDate.year.toString().padLeft(4, '0')}-${serviceDate.month.toString().padLeft(2, '0')}-${serviceDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
      };
}
