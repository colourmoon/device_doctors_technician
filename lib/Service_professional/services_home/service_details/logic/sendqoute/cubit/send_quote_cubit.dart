import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../utility/auth_shared_pref.dart';
import '../../../../../commons/common_toast.dart';
import '../../../model/service_details_model.dart';
import '../../../screen/create_qoute_screen.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

part 'send_quote_state.dart';

class SendQuoteCubit extends Cubit<SendQuoteState> {
  SendQuoteCubit() : super(SendQuoteInitial());

  sendquoate(
      {required String orderId,
      required String serviceId,
      required List<VisitAndQuote> servicesList}) async {
    emit(SendQuoteloading());
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
        "service_id": serviceId,
        "add_on_services_json": jsonEncode(servicesList),
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().send_quote_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(SendQuotesuccess());
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(SendQuoteerror());
        } else {
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          emit(SendQuoteerror());
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(SendQuoteerror());

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

  // add quote
  addquoate(
      {required String orderId,
      required String serviceId,
      required List<jsonModel> servicesList}) async {
    emit(AddQuoteloading());
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
        "service_id": serviceId,
        "add_on_services_json": jsonEncode(servicesList),
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().add_quote_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(AddQuotesuccess());
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(SendQuoteerror());
        } else {
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          emit(AddQuoteerror());
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(AddQuoteerror());

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
