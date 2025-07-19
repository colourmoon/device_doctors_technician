import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../utility/auth_shared_pref.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../../../../commons/common_toast.dart';
import '../../model/profile_details_model.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  fetchProfileData(bool? dontLoad) async {
    if (dontLoad == false) {
      emit(state.copyWith(profileDetils: null
          //   ProfileDetailsFetchingModel(
          //       id: "",
          //       accessToken: "",
          //       ownerName: "",
          //       mobile: "",
          //       isOnline: "0",
          //       contactEmail: "",
          //       languageKnown: "",
          //       gender: "",
          //       displayImage: "",
          //       countryName: "",
          //       cityName: "",
          //       services: "",
          //       notificationCount: "0",
          //       newOrdersCount: "0"),
          ));
    }

    if (dontLoad == true) {
      print('ashaaaaaaa11111');
      emit(state.copyWith(StatusUpdateSuccess: false, profileDetils: null));
    } else {
      print('ashaaaaaaa222222 ${state.profileDetils} ${state.fetchLoading}');

      emit(state.copyWith(
        fetchLoading: true,
        StatusUpdateSuccess: false,
      ));
    }

    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      print("profile body data: ${bodyData}");
      // print(bodyData);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().profile_fetch_endpoint, data: data)
          .then((response) {
        print("profile res: $response");
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          emit(state.copyWith(
            profileDetils: ProfileDetailsFetchingModel.fromJson(res["data"]),
            fetchLoading: false,
          ));
          // emit(OtpInitial());
          // _resendDelay = 60;
          // startResendTimer();
          // CommonSuccessToastwidget(toastmessage: res["message"]);
        } else {
          emit(state.copyWith(fetchLoading: false));
          // emit(ProfileFailed());
          // emit(OtpError('Invalid OTP, please try again.'));
          CommonToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        }
      });
    } catch (e) {
      // emit(ProfileFailed());

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

  updateStatus({required String status}) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "status": status
      };
      // print(bodyData);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().update_status_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          print("Status updated successfully");
          emit(state.copyWith(StatusUpdateSuccess: true, isLoading: false));
          // emit(OtpInitial());
          // _resendDelay = 60;
          // startResendTimer();
          // CommonSuccessToastwidget(toastmessage: res["message"]);
        } else {
          // emit(OtpError('Invalid OTP, please try again.'));
          CommonToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
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
}
