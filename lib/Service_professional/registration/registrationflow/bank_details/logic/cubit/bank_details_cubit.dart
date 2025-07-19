import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../commons/common_toast.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../model/bank_details_model.dart';
part 'bank_details_state.dart';

class BankDetailsCubit extends Cubit<BankDetailsState> {
  BankDetailsCubit() : super(BankDetailsState());
  updateBankDetails({required Map<String, dynamic> bodyData}) async {
    print("update clicked*************");
    emit(state.copyWith(isLoading: true, fetchedDetails: null));
    // print(state.fetchedDetails);
    try {
      print(bodyData);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().update_bank_details_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          emit(state.copyWith(isLoading: false, Success: "valid"));
        } else {
          CommonToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(isLoading: false, failed: res["message"]));

          print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        }
      });
    } catch (e) {
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

  getBankDetails() async {
    emit(state.copyWith(detailsLoading: true, Success: ""));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().get_bank_details_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          print("get profile:${res["data"]}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          emit(state.copyWith(
              detailsLoading: false,
              Success: "",
              fetchedDetails: BankDetailsModel.fromJson(res["data"][0])));
        } else {
          CommonToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(detailsLoading: false, failed: res["message"]));

          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        }
      });
    } catch (e) {
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
