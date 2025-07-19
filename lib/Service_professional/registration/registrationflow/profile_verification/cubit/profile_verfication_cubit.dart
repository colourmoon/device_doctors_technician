import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import '../../../../commons/common_toast.dart';
import '../../../../services_home/more_tab/logic/cubit/logout_cubit.dart';
import '../model/profile_verification_model.dart';

part 'profile_verfication_state.dart';

class ProfileVerficationCubit extends Cubit<ProfileVerficationState> {
  ProfileVerficationCubit() : super(ProfileVerficationState());
  profileVerificationCheck() async {
    emit(state.copyWith(isLoading: true));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().profile_verification_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          print("verification res:${res["data"]}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          emit(state.copyWith(
              isLoading: false,
              verificationModel:
                  ProfileVerficationModel.fromJson(res["data"])));
        } else {
          CommonToastwidget(toastmessage: res["message"]);

          emit(state.copyWith(
            isLoading: false,
          ));
          if (res['error_type'] == 'invalid_login') {
            emit(state.copyWith(error: true));
          }
        }
      });
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else if (e.response?.statusCode == 508) {
          return profileVerificationCheck();
        } else {
          throw ("Unable to update token");
        }
      } else {
        rethrow;
      }
    }
  }
}
