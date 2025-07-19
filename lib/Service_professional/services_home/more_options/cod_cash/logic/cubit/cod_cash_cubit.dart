import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../utility/auth_shared_pref.dart';
import '../../../customer_tips/model/customer_tips_model.dart';
import '../../model/cod_cash_model.dart';

part 'cod_cash_state.dart';

class CodCashCubit extends Cubit<CodCashState> {
  CodCashCubit() : super(CodCashState(codCashList: []));

  getCodCashList() async {
    try {
      emit(state.copyWith(dataLoaded: true, payoutError: null));
      print('fetch new orders cubit');

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      print("********************$bodyData");
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().cod_cash_endpoint, data: data)
          .then((response) {
        print("orders ****000***${response}");

        dynamic res = response.data;

        // print("orders ****11***${res["data"]["new_orders"]}");

        if (res["err_code"] == "valid") {
          List<CodCashModel> resList = [];
          for (int i = 0; i < res["data"].length; i++) {
            resList.add(CodCashModel.fromJson(res["data"][i]));
          }
          emit(state.copyWith(
              codCashList: resList,
              dataLoaded: false,
              currentBalance: res["current_balance"].toString(),
              limit: res["limit"].toString()));

          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          emit(state.copyWith(payoutError: res["message"], dataLoaded: false));
          // emit(state.copyWith(dataLoaded: false));
        }
        // else {
        //   emit(state.copyWith(dataLoaded: false));
        // }
      });
    } catch (e) {
      emit(state.copyWith(payoutError: e.toString(), dataLoaded: false));

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
