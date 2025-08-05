import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import '../../../../commons/common_toast.dart';
import '../../../../services_bottombar/screen/services_bottombar_screen.dart';
import '../../model/service_details_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../screen/service_details_screen.dart';
part 'service_details_state.dart';

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(ServiceDetailsState()) {}
  fetchServiceDetails({required String orderId}) async {
    emit(state.copyWith(
        isLoading: true, reachedSuccesss: "", completeSuccesss: ""));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().orders_details_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          for (var item in res["data"]["service_items"]) {
            if (item["has_visit_and_quote"] == "yes") {
              emit(state.copyWith(hasVisitAndQuote: true));
              break; // No need to continue checking once found
            } else {
              emit(state.copyWith(hasVisitAndQuote: false));
            }
          }
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          emit(state.copyWith(
              isStatusLoading: false,
              isLoading: false,
              serviceDetails: ServiceDetailsModel.fromJson(res["data"])));
          print("verification res:${res["data"]}");
          print(state.serviceDetails!.orderId);
        } else {
          CommonToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(
            isLoading: false,
            error: res["message"],
          ));
        }
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
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

// reached location'
  reachedLocation({required String orderId}) async {
    emit(state.copyWith(isStatusLoading: true, reachedFailed: ""));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().reached_location_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(
            isStatusLoading: false,
            reachedSuccesss: "success",
          ));
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          print("failed case : ${res["message"]}");
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(state.copyWith(
            isStatusLoading: false,
            reachedFailed: res["message"],
          ));
        } else {
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          emit(state.copyWith(
            isStatusLoading: false,
            reachedFailed: res["message"],
          ));
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(state.copyWith(
        isStatusLoading: false,
        reachedFailed: e.toString(),
      ));

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

  validatePin({required String orderId, required String pin}) async {
    emit(state.copyWith(isStatusLoading: true));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
        "pin": pin
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().verify_pin_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(
            isStatusLoading: false,
            pinVerified: "success",
          ));
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(state.copyWith(
            isStatusLoading: false,
            pinError: res["message"],
          ));
        } else {
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          emit(state.copyWith(
            isStatusLoading: false,
            pinError: res["message"],
          ));
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(state.copyWith(
        isStatusLoading: false,
        pinError: e.toString(),
      ));

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

  // complete service
  completeOrder(
      {required String orderId,
      required String reason,
          Function()? success,
      required BuildContext context,
      required String otp}) async {
    emit(state.copyWith(isStatusLoading: true, reachedSuccesss: ''));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
        "reason": reason,
        "otp": otp,
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().complete_order_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);

          success?.call();
          emit(state.copyWith(
            isStatusLoading: false,
            reachedSuccesss: "success",
          ));
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(state.copyWith(
            isStatusLoading: false,
            reachedFailed: res["message"],
          ));
        } else {
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          emit(state.copyWith(
            isStatusLoading: false,
            reachedFailed: res["message"],
          ));
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(state.copyWith(
        isStatusLoading: false,
        reachedFailed: e.toString(),
      ));

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

  void updateSelectedOption(String value) {
    emit(state.copyWith(selectedOption: value));
  }
}

class OrderPaymentRepository {
  final ValueNotifier<bool> markCompleteNotifier = ValueNotifier(false);
  final Dio dio = BaseApi().dioClient();

  Future<bool> completePayAfterService({
    required BuildContext context,
    required String accessToken,
    required String orderId,
    required String paymentType, // 'cash' or 'online'
  }) async {
    markCompleteNotifier.value = true;

    try {
      final response = await dio.post(
          'homeservices/vendor/orders/complete_pay_after_service',
          data: await FormData.fromMap(
            {
              'access_token': accessToken,
              'order_id': orderId,
              'payment_type': paymentType,
            },
          ));

      final res = response.data;

      if (res['err_code'] == 'valid') {
        // Navigate to success screen
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                const ServicesBottomBarScreen(initialIndex: 1),
          ),
          (route) => false,
        );

        markCompleteNotifier.value = false;
        return true;
      } else {
        Fluttertoast.showToast(msg: res['message'] ?? 'Unknown error');
        print("Failed: ${res['message'] ?? 'Unknown error'}");
        markCompleteNotifier.value = false;
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
      print("Exception occurred: $e");
      markCompleteNotifier.value = false;
      return false;
    }
  }
}
