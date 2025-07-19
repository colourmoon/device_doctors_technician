import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';
import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../commons/common_toast.dart';
import 'otp_verification_state.dart';

enum OtpStatus { Initial, Loading, Verified, Error }

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  late Timer _timer;
  int _resendDelay = 60;

  OtpVerificationCubit() : super(OtpInitial()) {
    startResendTimer();
  }

  void verifyOtp(Map<String, dynamic> bodyData) async {
    emit(OtpLoading());
    try {
      // print(bodyData);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().otp_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          Constants.prefs
              ?.setString("provider_access_token", res["access_token"]);
          print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(OtpVerified());
        } else {
          emit(OtpError('Invalid OTP, please try again.'));
          CommonToastwidget(toastmessage: res["message"]);
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

  void startResendTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendDelay == 0) {
        _timer.cancel();
        emit(OtpResend());
      } else {
        emit(OtpResendTimer(_resendDelay));
        _resendDelay--;
      }
    });
  }

  void resendOtp(String mobileNumber) async {
    emit(OtpLoading());
    try {
      Map<String, dynamic> bodyData = {"mobile": mobileNumber};
      // print(bodyData);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().resend_otp_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          emit(OtpInitial());
          _resendDelay = 60;
          startResendTimer();
          CommonSuccessToastwidget(toastmessage: res["message"]);
        } else {
          emit(OtpError('Invalid OTP, please try again.'));
          CommonToastwidget(toastmessage: res["message"]);
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

    // Here you can add the logic to resend OTP
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
