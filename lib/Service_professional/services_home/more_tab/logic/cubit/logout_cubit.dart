import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import 'package:dio/dio.dart';
part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  logoutapi() async {
    try {
      emit(LogoutLoading());

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      print("********************$bodyData");
      FormData data = FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().logout_endpoint, data: data)
          .then((response) {
        print("orders ****000***$response");

        dynamic res = response.data;

        // print("orders ****11***${res["data"]["new_orders"]}");

        if (res["err_code"] == "valid") {
          Constants.prefs?.remove("provider_access_token");
          emit(LogoutSuccess());
        }
        //  else if (res["err_code"] == "invalid") {
        //    emit(state.copyWith(payoutError: e.toString(), dataLoaded: false));
        //   // emit(state.copyWith(dataLoaded: false));
        // } else {
        //   emit(state.copyWith(dataLoaded: false));
        // }
      });
    } catch (e) {
      emit(LogoutFailed());
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
