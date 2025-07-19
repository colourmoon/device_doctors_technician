import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import '../../../../commons/pagination_model/pagination_model.dart';
import '../model/all_orders_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

class AllOrdersListRepository extends BaseApi {
  Future<AllOrdersListModel> fetchAllOrderList(
      {int page = 1,
      required String fromdate,
      required String todate,
      required String status}) async {
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "status": status,
        "from_date": fromdate,
        "to_date": todate,
        "page_no": page
      };

      FormData data = FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().all_orders_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          print(response.data);

          return AllOrdersListModel.fromJson(response.data['data']);
        } else if (response.data['err_code'] == "invalid") {
          throw res['message'];
        }
        {
          return AllOrdersListModel(
              results: [],
              paginationTestModel:
                  PaginationTestModel(currentPage: 0, lastPage: 0));
        }
      });
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Unable to connect to the server at this time. Please try again");
        }
      }
      rethrow;
    }
  }
}
