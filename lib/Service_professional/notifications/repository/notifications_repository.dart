import 'package:dio/dio.dart';

import 'package:device_doctors_technician/comman/Api/Base-Api.dart';

import '../../../utility/auth_shared_pref.dart';
import '../models/load_more_notifications_model.dart';

class NotificationsRepository extends BaseApi {
  NotificationsRepository();

  ///notification list
  //  Future<NotificationsDataNewResponseModel> featchNotifications(
  //     {int page = 1,
  //   required String seenStatus,
  // }) async {
  //   try {
  //     final accesstoken = await authPref.getAccessToken();
  //     return await makeIsolateApiCallWithInternetCheck(
  //       (Map<String, dynamic> params) async {
  //         final accessToken = params['access_token']! as String;
  //         return _featchNotificationsIsolate(
  //           accessToken: accessToken,
  //           page: page,
  //           seenStatus: seenStatus,

  //         );
  //       },
  //       {
  //         'access_token': accesstoken,
  //       },
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  featchNotifications({
    int page = 1,
    required String seenStatus,
  }) async {
    try {
      // final accesstoken = Constants.prefs?.getString("provider_access_token");
      FormData data = FormData.fromMap({
        'access_token': Constants.prefs?.getString("provider_access_token"),
        'type': seenStatus,
        'page_no': page,
        // 'limit': 10,
      });
      print("form data of notifications : ${data.fields}");
      final dio = dioClient();
      return await dio
          .post("homeservices/vendor/notifications", data: data)
          .then((response) {
        print("res :>>>>>>>: $response");
        if (response.data['err_code'] == "valid") {
          var results = response.data['data'];
          if (page == 1) {
            return [
              NotificationsDataNewResponseModel.fromJson(results),
              response.data['err_code']
            ];
          } else
            return NotificationsDataNewResponseModel.fromJson(results);
        } else {
          return [null, response.data['err_code']];
          // throw (response.data['message']);
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        }
      }
      rethrow;
    }
  }

  ///notification single view
  //  Future<bool> singleViewNotifications({required String id}) async {
  //   try {

  //     return await makeIsolateApiCallWithInternetCheck(
  //       (Map<String, dynamic> params) async {
  //         final accessToken = params['access_token']! as String;
  //         return _singleViewNotificationsIsolate(
  //           accessToken: accessToken,
  //           id: id,
  //         );
  //       },
  //       {
  //         'access_token': accesstoken,
  //       },
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<bool> singleViewNotifications({required String id}) async {
    try {
      // final accesstoken = ;
      FormData data = FormData.fromMap({
        'access_token': Constants.prefs?.getString("provider_access_token"),
        'notification_id': id,
      });
      final dio = dioClient();
      return await dio
          .post("homeservices/vendor/notifications/updateasread", data: data)
          .then((response) {
        if (response.data['err_code'] == "valid") {
          return response.data['err_code'] == "valid";
        } else {
          throw (response.data['message']);
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        }
      }
      rethrow;
    }
  }

  ///notification markAsReadAll
  // Future<bool> markAsReasAllNotifications() async {
  //   try {
  //     final accesstoken = await authPref.getAccessToken();
  //     return await makeIsolateApiCallWithInternetCheck(
  //       (Map<String, dynamic> params) async {
  //         final accessToken = params['access_token']! as String;
  //         return _markAsReasAllNotificationsIsolate(
  //           accessToken: accessToken,
  //         );
  //       },
  //       {
  //         'access_token': accesstoken,
  //       },
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<bool> markAsReasAllNotifications() async {
    try {
      final accesstoken = Constants.prefs?.getString("provider_access_token");
      FormData data = FormData.fromMap({
        'access_token': accesstoken,
      });
      final dio = dioClient();
      return await dio
          .post("homeservices/vendor/notifications/updateasallread", data: data)
          .then((response) {
        if (response.data['err_code'] == "valid") {
          return response.data['err_code'] == "valid";
        } else {
          throw (response.data['message']);
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        }
      }
      rethrow;
    }
  }
}
