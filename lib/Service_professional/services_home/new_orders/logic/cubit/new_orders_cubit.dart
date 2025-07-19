import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:device_doctors_technician/comman/Api/Base-Api.dart';
import 'package:device_doctors_technician/comman/Api/end_points.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'dart:convert';

import '../../model/new_orders_model.dart';

part 'new_orders_state.dart';

class NewOrdersCubit extends Cubit<NewOrdersState> {
  NewOrdersCubit() : super(NewOrdersState());

  fetchNewOrders({required String type, fromdate, todate}) async {
    // emit(state.copyWith(acceptOrderFailed: null, acceptOrderSuccess: null));

    emit(state.copyWith(newOrder: [], isLoading: true, error: ""));
    try {
      print('fetch new orders cubit');

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "type": type,
      };
      if (type == "completed") {
        bodyData["from_date"] = fromdate;
        bodyData["to_date"] = todate;
      }
      print("********************$bodyData");
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().orders_fetch_endpoint, data: data)
          .then((response) {
        print("orders ****000***${response}");

        dynamic res = response.data;
        print("orders ****11***${res}");

        if (res["err_code"] == "valid") {
          List<NewOrderModel> ordersList = [];
          for (int i = 0; i < res["data"].length; i++) {
            ordersList.add(NewOrderModel.fromJson(res["data"][i]));
          }
          ordersList.forEach(
            (element) {
              for (int i = 0; i < element.serviceItems.length; i++) {
                if (element.serviceItems[i].hasVisitAndQuote == "yes") {
                  element.orderhasvisitAndQuote = true;
                  break;
                }
              }
              // element.serviceItems.forEach((item) {
              //   if (item.hasVisitAndQuote == "yes") {
              //     element.orderhasvisitAndQuote = true;
              //   }
              // }
              // );
            },
          );

          emit(state.copyWith(
              isLoading: false,
              newOrder: ordersList,
              ordersFetched: true,
              acceptOrderSuccess: null,
              acceptOrderFailed: null,
              rejectOrderSuccess: null,
              error: ""));
          print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          if (res["message"] == "No Services") {
            print("invalid no services **************************************");
            emit(state.copyWith(
              isLoading: false,
              newOrder: null,
              ordersFetched: true,
              acceptOrderSuccess: null,
              acceptOrderFailed: null,
              rejectOrderSuccess: null,
              error: res["message"],
            ));
          } else {
            emit(state.copyWith(
              isLoading: false,
              ordersFetched: true,
              acceptOrderSuccess: null,
              acceptOrderFailed: null,
              rejectOrderSuccess: null,
              error: res["message"],
            ));
          }
        }
      });
    } catch (e) {
      print("error state in $type orders 333");
      emit(state.copyWith(isLoading: false, error: e.toString()));

      print(e);
      if (e is DioException) {
        print("error state in $type orders deo");
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else if (e.response?.statusCode == 508) {
          return fetchNewOrders(type: type, fromdate: fromdate, todate: todate);
        } else {
          throw ("Unable to update token");
        }
      } else {
        rethrow;
      }
    }
  }

  // accept order

  acceptOrder({required String orderId}) async {
    final accesToken =
        await Constants.prefs?.getString("provider_access_token");
    print("accept order : ${accesToken}");
    emit(state.copyWith(isLoading: true));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": accesToken,
        "order_id": orderId,
      };
      print(bodyData.values);
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().accept_order_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(
              isLoading: false,
              acceptOrderSuccess: "success",
              newOrder: null,
              acceptOrderFailed: null));
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else {
          emit(state.copyWith(
              isLoading: false,
              acceptOrderFailed: res["message"],
              acceptOrderSuccess: null));

          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          // emit(state.copyWith(
          //     isLoading: false,
          //     acceptOrderFailed: res["message"],
          //     acceptOrderSuccess: null));
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(state.copyWith(
          isLoading: false,
          acceptOrderFailed: e.toString(),
          acceptOrderSuccess: null));

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

  rejectOrder({required String orderId}) async {
    emit(state.copyWith(isLoading: true));
    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "order_id": orderId,
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().reject_order_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(
              isLoading: false,
              rejectOrderSuccess: "success",
              newOrder: null,
              rejectOrderFailed: null));
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          CommonToastwidget(
            toastmessage: res["message"],
          );
          emit(state.copyWith(
              isLoading: false,
              rejectOrderFailed: res["message"],
              rejectOrderSuccess: null));
        } else {
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
          emit(state.copyWith(
              isLoading: false,
              rejectOrderFailed: res["message"],
              rejectOrderSuccess: null));
        }
      });
    } catch (e) {
      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");
      emit(state.copyWith(
          isLoading: false,
          rejectOrderFailed: e.toString(),
          rejectOrderSuccess: null));

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

  // complete order
}
