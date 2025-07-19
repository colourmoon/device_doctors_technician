import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../../comman/Api/end_points.dart';
import '../../../../../../../utility/auth_shared_pref.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../../../../../commons/common_toast.dart';
part 'updat_profile_state.dart';

class UpdatProfileCubit extends Cubit<UpdatProfileState> {
  UpdatProfileCubit() : super(UpdatProfileInitial());

  updateProfile({required String name, required String languages}) async {
    emit(UpdatProfileLoading());
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "name": name,
        "languages": languages,
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().update_profile_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(UpdatProfileSuccess());
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(UpdatProfileError());
        } else {
          emit(UpdatProfileError());

          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
        }
      });
    } catch (e) {
      emit(UpdatProfileError());

      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");

      print(e);
      if (e is DioException) {
        emit(UpdatProfileError());

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
