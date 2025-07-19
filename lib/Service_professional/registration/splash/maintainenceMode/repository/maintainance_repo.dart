import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:device_doctors_technician/comman/Api/Base-Api.dart';

import '../model/maintainance_mode_model.dart';
import '../model/version_check_model.dart';

class MaintainanceModeRepository extends BaseApi {
  MaintainanceModeRepository();
  // Future<MaintainanceModel> MaintainanceModeApi() async {
  //   try {
  //     final FormMap = <String, dynamic>{
  //       // 'access_token': await SharedPref().getString("access_token"),
  //     };
  //     FormData data = FormData.fromMap(FormMap);
  //     final dio = dioClient();
  //     return await dio
  //         .get('homeservices/vendor/Maintenance_check')
  //         .then((response) {
  //       print(jsonEncode(response.data));
  //       if (response.data['err_code'] == "valid") {
  //         print(response.data['message']);
  //         var resp = response.data;
  //         return MaintainanceModel.fromJson(resp["data"]);
  //       } else {
  //         throw (response.data['message']);
  //       }
  //     });
  //   } catch (e) {
  //     if (e is DioException) {
  //       if (e.response?.statusCode == 500) {
  //         throw ("Server error");
  //       } else {
  //         throw ("Unable to get data");
  //       }
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  // version check

  Future<VersionCheckModel> VersionCheckApi() async {
    try {
      final FormMap = <String, dynamic>{
        'platform_type': "android",
        "version": BaseApi().vendor_android_version,
      };
      FormData data = FormData.fromMap(FormMap);
      final dio = dioClient();
      return await dio
          .post('homeservices/vendor/Version_control', data: data)
          .then((response) {
        print(jsonEncode(response.data));
        // if (response.data['err_code'] == "valid") {
        //   print(response.data['message']);
        //   var resp = response.data;

        // } else {
        //   throw (response.data['user_android_app_link']);
        // }
        return VersionCheckModel.fromJson(response.data);
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else {
          throw ("Unable to get data");
        }
      } else {
        rethrow;
      }
    }
  }
}
