import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../utility/auth_shared_pref.dart';
import '../../model/customer_tips_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
part 'cusomer_tips_state.dart';

class CusomerTipsCubit extends Cubit<CusomerTipsState> {
  CusomerTipsCubit() : super(CusomerTipsState(tipsList: []));

  getTipsList() async {
    try {
      print('fetch new orders cubit 000');

      emit(state.copyWith(
        dataLoaded: true,
      ));
      print('fetch new orders cubit');

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      print("********************$bodyData");
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().tips_endpoint, data: data)
          .then((response) {
        print("orders ****000***${response}");

        dynamic res = response.data;

        // print("orders ****11***${res["data"]["new_orders"]}");

        if (res["err_code"] == "valid") {
          print("<<<<<<<<");
          List<TipsListModel> resList = [];
          for (int i = 0; i < res["data"].length; i++) {
            resList.add(TipsListModel.fromJson(res["data"][i]));
          }

          emit(state.copyWith(
              tipsList: resList,
              dataLoaded: false,
              totalAmount: res["total_tip"].toString()));
          print(">>>>>>>");

          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          emit(state.copyWith(tipsList: [], dataLoaded: false));
          // emit(state.copyWith(dataLoaded: false));
        }
        // else {
        //   emit(state.copyWith(dataLoaded: false));
        // }
      });
    } catch (e) {
      print("error customer tips state: ${e}");
      emit(state.copyWith(
        dataLoaded: false,
        payoutError: e.toString(),
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
}
