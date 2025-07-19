import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/cms_data_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/help_support_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/payout_list_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/refer_list_model.dart';
import 'package:device_doctors_technician/comman/Api/Base-Api.dart';
import 'package:dio/dio.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';
import 'package:device_doctors_technician/utility/sharedPref.dart';

import '../../../comman/Api/end_points.dart';
import '../../commons/pagination_model/pagination_model.dart';
import 'payout_history/model/payouts_model.dart';

class MoreOptionsRepository extends BaseApi {
  final accessToken = Constants.prefs?.getString("provider_access_token");

  Future<ReferListModel> fetchReferralList() async {
    try {
      FormData formData = FormData.fromMap({'access_token': accessToken});

      final dio = dioClient();
      print(formData.fields);

      final response = await dio.post("homeservices/vendor/refer_friend/list",
          data: formData);
      print(response);
      if (response.data['err_code'] == "valid") {
        return ReferListModel.fromJson(response.data);
      } else {
        return ReferListModel(errCode: "invalid", referedAmount: "0", data: []);
        // throw (response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Unable to connect to the server at this time. Please try again");
        }
      }
      rethrow;
    }
  }

  Future<void> submitReferral(name, mobile, age, service, address) async {
    try {
      FormData formData = FormData.fromMap({
        'access_token': accessToken,
        'name': name,
        'mobile': mobile,
        'age': age,
        'service': service,
        "address": address
      });

      final dio = dioClient();
      print(formData.fields);

      final response =
          await dio.post("homeservices/vendor/refer_friend", data: formData);
      print(response);
      if (response.data['err_code'] == "valid") {
        return response.data;
      } else {
        throw (response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Unable to connect to the server at this time. Please try again");
        }
      }
      rethrow;
    }
  }

  Future<CmsDataModel> fetchCmsData(type) async {
    try {
      FormData formData = FormData.fromMap({'access_token': accessToken});

      final dio = dioClient();
      print(formData.fields);

      final response = await dio.post(
          type == 'Terms And Conditions'
              ? "homeservices/vendor/terms_and_conditions"
              : "homeservices/vendor/privacy_policy",
          data: formData);
      print(response);
      if (response.data['err_code'] == "valid") {
        return CmsDataModel.fromJson(response.data);
      } else {
        throw (response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Unable to connect to the server at this time. Please try again");
        }
      }
      rethrow;
    }
  }

  Future<void> submitHelSupport(
      File? filePath, type, describeIssue, orderId) async {
    String? fileName = filePath?.path.split('/').last;
    final formData = FormData.fromMap({
      "access_token": accessToken,
      'image': filePath == null
          ? null
          : await MultipartFile.fromFile(filePath.path, filename: fileName),
      'type': type,
      'describe_issue': describeIssue,
      'order_id': orderId
    });
    try {
      Response response = await dioClient()
          .post('homeservices/vendor/help_and_support', data: formData);
      if (response.statusCode == 200) {
        var result = response.data;
        print(result);
        CommonSuccessToastwidget(toastmessage: response.data['message']);
        return result;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          Fluttertoast.showToast(
              msg: 'Server Error', backgroundColor: Colors.red);
        } else {
          Fluttertoast.showToast(
              msg: e.response.toString(),
              fontSize: 12,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white);
        }
      }
      rethrow;
    }
  }

  Future<HelpSupportListModel> fetchRaisedIssue(type) async {
    try {
      FormData formData = FormData.fromMap({
        'access_token': accessToken,
        'type': type,
      });

      final dio = dioClient();
      print(formData.fields);

      final response = await dio
          .post("homeservices/vendor/help_and_support/list", data: formData);
      print(response);
      if (response.data['err_code'] == "valid") {
        return HelpSupportListModel.fromJson(response.data);
      } else {
        throw (response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Unable to connect to the server at this time. Please try again");
        }
      }
      rethrow;
    }
  }

  Future<PayoutsListModel> fetchPayoutList(
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

      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().payouts_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          print(response.data);

          return PayoutsListModel.fromJson(response.data['data']);
        } else if (response.data['err_code'] == "invalid") {}
        {
          return PayoutsListModel(
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

  // Future<PayoutListModel> fetchPayoutList(fromDate, toDate, status) async {
  //   try {
  //     FormData formData = FormData.fromMap({
  //       'access_token': accessToken,
  //       'from_date': fromDate,
  //       'to_date': toDate,
  //       "status": status
  //     });

  //     final dio = dioClient();
  //     print(formData.fields);

  //     final response =
  //         await dio.post("homeservices/vendor/payouts", data: formData);
  //     print(response);
  //     if (response.data['err_code'] == "valid") {
  //       return PayoutListModel.fromJson(response.data);
  //     } else {
  //       throw (response.data['message']);
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       if (e.response?.statusCode == 500) {
  //         throw ("Unable to connect to the server at this time. Please try again");
  //       }
  //     }
  //     rethrow;
  //   }
  // }
}
