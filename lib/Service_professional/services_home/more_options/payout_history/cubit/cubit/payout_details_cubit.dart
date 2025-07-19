import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/payout_history/model/payouts_details_model.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../utility/auth_shared_pref.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

import '../../../../../commons/common_toast.dart';
part 'payout_details_state.dart';

class PayoutDetailsCubit extends Cubit<PayoutDetailsState> {
  PayoutDetailsCubit() : super(PayoutDetailsInitial());

  fetchDetails({required String orderId}) async {
    emit(PayoutDetailsLoading());
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().payouts_details_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(PayoutDetailsFetched(
              payoutDetails: PayoutsDetailsModel.fromJson(res["data"])));
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          print("failed case : ${res["message"]}");
          // CommonToastwidget(
          //   toastmessage: res["message"],
          // );
          emit(PayoutDetailsError(error: res["message"]));
        } else {
          emit(PayoutDetailsError(error: res["message"]));

          // print("error state in $type orders 222");
        }
      });
    } catch (e) {
      emit(PayoutDetailsError(error: e.toString()));

      // print("error state in $type orders 333");

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
