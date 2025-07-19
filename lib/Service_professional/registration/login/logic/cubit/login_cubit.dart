import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../commons/common_toast.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  login(Map<String, dynamic> bodyData) async {
    emit(LoginLoading());
    try {
      print(bodyData);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().login_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          Constants.prefs
              ?.setString("provider_access_token", res["data"]["access_token"]);
          Constants.prefs?.setString("provider_id", res["data"]["id"]);

          // CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(LoginSuccess());
        } else {
          CommonToastwidget(toastmessage: res["message"]);
          emit(LoginFailed());
        }
      });
    } catch (e) {
      emit(LoginFailed());
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
