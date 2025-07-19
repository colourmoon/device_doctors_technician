import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import '../../../../commons/common_toast.dart';
import '../../model/services_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesState(servicesList: []));
  // static ServicesState _initialState() {
  //   currentState =
  //   return ServicesState(servicesList: []);
  // }

  sendquoate({required bool fromUpdate}) async {
    if (!fromUpdate) {
      emit(state.copyWith(isLoading: true));
    }

    try {
      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
      };
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().services_list_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          List<ServicesModel> reslist = [];
          for (int i = 0; i < res["data"].length; i++) {
            reslist.add(ServicesModel.fromJson(res["data"][i]));
          }
          print("^^^^^^^^^^^^^^^");
          emit(state.copyWith(
              servicesList: reslist, isLoading: false, selectedServiceId: ''));
          print("${state.isLoading}");
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          emit(state.copyWith(
              servicesList: [],
              isLoading: false,
              selectedServiceId: '',
              error: ""));
          CommonToastwidget(
            toastmessage: res["message"],
          );
        } else {
          emit(state.copyWith(
              servicesList: null,
              isLoading: false,
              selectedServiceId: '',
              error: res["message"]));
          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
        }
      });
    } catch (e) {
      emit(state.copyWith(
          servicesList: null,
          isLoading: false,
          selectedServiceId: '',
          error: e.toString()));
      CommonToastwidget(
        toastmessage: e.toString(),
      );

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

  updateServiceStatus(
      {required String serviceId, required String categoryId}) async {
    // emit(state.copyWith(isLoading: true));
    print("ashaaaa11111");
    print("ashaaaa111122");

    try {
      emit(state.copyWith(selectedServiceId: serviceId));

      Map<String, dynamic> bodyData = {
        "access_token": Constants.prefs?.getString("provider_access_token"),
        "service_id": serviceId,
        "category_id": categoryId
      };
      print("ashaaaa11111333");
      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().update_service_status_endpoint, data: data)
          .then((response) {
        print("ashaaaa1111144");

        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(
            toastmessage: res["message"],
          );
          emit(state.copyWith(
            statusUpdatedSuccess: true,
          ));
          sendquoate(fromUpdate: true);
          // print("$type orders:${state.newOrder}");
          // CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        } else if (res["err_code"] == "invalid") {
          emit(state.copyWith(
            statusUpdatedSuccess: false,
          ));

          CommonToastwidget(
            toastmessage: res["message"],
          );
        } else {
          emit(state.copyWith(
            statusUpdatedSuccess: false,
          ));

          CommonToastwidget(
            toastmessage: res["message"],
          );

          // print("error state in $type orders 222");
        }
      });
    } catch (e) {
      print("error in catche:: $e");
      emit(state.copyWith(
        statusUpdatedSuccess: false,
      ));

      CommonToastwidget(
        toastmessage: e.toString(),
      );

      // print("error state in $type orders 333");

      print(e);
      if (e is DioException) {
        emit(state.copyWith(
          statusUpdatedSuccess: false,
        ));

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

  // void changeStatus(int index) {
  //   final currentState = state;
  //   print("current state: $currentState");
  //   if (index >= 0 && index < currentState.servicesList.length) {
  //     final List<ServicesModel> updatedServicesList =
  //         List.from(currentState.servicesList); // Create a copy of the list
  //     updatedServicesList[index] = updatedServicesList[index].copyWith(
  //       serviceStatus: !updatedServicesList[index].serviceStatus,
  //     ); // Update the service status
  //     print("updated list state: ${updatedServicesList[index].serviceStatus}");
  //     emit(currentState.copyWith(servicesList: updatedServicesList));
  //   }
  // }
}
