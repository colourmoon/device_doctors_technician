import '../../commons/pagination_model/pagination_model.dart';
import 'notifications_data_model.dart';

class NotificationsDataNewResponseModel {
  final List<NotificationsDataNewDataModel> results;
  PaginationTestModel paginationTestModel;

  NotificationsDataNewResponseModel({
    required this.results,
    required this.paginationTestModel,
  });

  factory NotificationsDataNewResponseModel.emptyModel() =>
      NotificationsDataNewResponseModel(
          results: [], paginationTestModel: PaginationTestModel.initial());
  factory NotificationsDataNewResponseModel.fromJson(
          Map<String, dynamic> json) =>
      NotificationsDataNewResponseModel(
        results: List<NotificationsDataNewDataModel>.from(json["results"]
            .map((x) => NotificationsDataNewDataModel.fromJson(x))),
        paginationTestModel: PaginationTestModel.fromMap(json),
      );

  //Use for pagination
  NotificationsDataNewResponseModel paginationCopyWith(
      {required NotificationsDataNewResponseModel newData}) {
    results.addAll(newData.results);
    paginationTestModel = newData.paginationTestModel;
    return NotificationsDataNewResponseModel(
        results: results, paginationTestModel: paginationTestModel);
  }
}
