import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../../utility/auth_shared_pref.dart';
import '../../model/ratings_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
part 'ratings_state.dart';

class RatingsCubit extends Cubit<RatingsState> {
  RatingsCubit() : super(RatingsState(ratingsList: []));

  getRatingsList() async {
    try {
      emit(state.copyWith(dataLoaded: true));
      print('fetch new orders cubit');

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      print("********************$bodyData");
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().ratings_endpoint, data: data)
          .then((response) {
        print("orders ****000***${response}");

        dynamic res = response.data;

        // print("orders ****11***${res["data"]["new_orders"]}");

        if (res["err_code"] == "valid") {
          List<RatingReviewsModel> resList = [];
          for (int i = 0; i < res["data"].length; i++) {
            resList.add(RatingReviewsModel.fromJson(res["data"][i]));
          }
          print("****rating****${res["average_rating"]}");
          emit(state.copyWith(
              ratingsList: resList,
              dataLoaded: false,
              averageRating: res["average_rating"].toString()));

          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else {
          emit(state.copyWith(
              payoutError: "No ratings found", dataLoaded: false));
        }
        //  else if (res["err_code"] == "invalid") {
        //    emit(state.copyWith(payoutError: e.toString(), dataLoaded: false));
        //   // emit(state.copyWith(dataLoaded: false));
        // } else {
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
