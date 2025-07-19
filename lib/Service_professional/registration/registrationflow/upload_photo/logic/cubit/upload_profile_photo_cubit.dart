import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../comman/env.dart';
import '../../../../../commons/common_toast.dart';
part 'upload_profile_photo_state.dart';

class UploadProfilePhotoCubit extends Cubit<UploadProfilePhotoState> {
  UploadProfilePhotoCubit() : super(UploadProfilePhotoInitial());

  uploadProfilePic(File displayImage) async {
    print("image path: ${displayImage.path}");
    String? fileName = displayImage.path.split('/').last;

    emit(UploadProfilePhotoLoading());
    final bodyData = dio.FormData.fromMap({
      "access_token": Constants.prefs?.getString("provider_access_token"),
      "image": displayImage == null
          ? null
          : await dio.MultipartFile.fromFile(displayImage.path,
              filename: fileName),
    });

    try {
      // print(bodyData);
      print("body data >>>>>>>>>>>>${bodyData}");
      dio.Response response = await BaseApi().dioClient().post(
          '$baseUrl${ApiEndPoints().update_profile_image_endpoint}',
          data: bodyData);
      print(response);
      dynamic res = response.data;
      print("${ApiEndPoints().registration_endpoint} responce: ${res}");
      if (res["err_code"] == "valid") {
        print("uploaded profile pic");
        emit(UploadProfilePhotoSuccess());
        CommonSuccessToastwidget(toastmessage: res["message"]);
      } else {
        emit(UploadProfilePhotofailure());

        CommonToastwidget(toastmessage: res["message"]);
      }
    } catch (e) {
      emit(UploadProfilePhotofailure());
      CommonToastwidget(toastmessage: e.toString());
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else {
          throw ("Unable to update token");
        }
      } else {
        rethrow;
      }
    }
  }
}
