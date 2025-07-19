import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../comman/Api/Base-Api.dart';
import '../../../../comman/Api/end_points.dart';
import '../../../../utility/auth_shared_pref.dart';
import '../../model/orders_count_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
part 'orders_count_state.dart';

class OrdersCountCubit extends Cubit<OrdersCountState> {
  OrdersCountCubit() : super(OrdersCountState());
  // OrdersCountModel ordersLoadingCount =
  //     OrdersCountModel(acceptedOrders: "0", newOrders: "0", ongoingOrders: "0");
  getOrdersCount() async {
    emit(state.copyWith(isLoading: true));
    try {
      print('fetch new orders cubit');

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      print("********************$bodyData");
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().orders_count_endpoint, data: data)
          .then((response) {
        print("orders ****000***${response}");

        dynamic res = response.data;
        // print("orders ****11***${res["data"]["new_orders"]}");

        if (res["err_code"] == "valid") {
          print("orders ****11***${res["data"]["new_orders"]}");
          // ordersLoadingCount = OrdersCountModel(
          //     newOrders: res["data"]["new_orders"],
          //     acceptedOrders: res["data"]["accepted_orders"],
          //     ongoingOrders: res["data"]["ongoing_orders"]);
          emit(state.copyWith(
              isLoading: false,
              orderscount: OrdersCountModel(
                  newOrders: res["data"]["new_orders"],
                  acceptedOrders: res["data"]["accepted_orders"],
                  ongoingOrders: res["data"]["ongoing_orders"])));

          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          emit(state.copyWith(
              isLoading: false,
              orderscount: OrdersCountModel(
                  newOrders: 0, acceptedOrders: 0, ongoingOrders: 0)));
        } else {
          emit(state.copyWith(
              isLoading: false,
              orderscount: OrdersCountModel(
                  newOrders: 0, acceptedOrders: 0, ongoingOrders: 0)));
        }
      });
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          orderscount: OrdersCountModel(
              newOrders: 0, acceptedOrders: 0, ongoingOrders: 0)));

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
