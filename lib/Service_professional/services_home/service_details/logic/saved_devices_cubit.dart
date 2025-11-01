import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../comman/Api/Base-Api.dart';
import '../../../../utility/auth_shared_pref.dart';
import '../model/model/os_response.dart';
import '../model/model/saved_devices_response.dart';

part 'saved_devices_state.dart';

class SavedDevicesCubit extends Cubit<SavedDevicesState> {
  SavedDevicesCubit() : super(const SavedDevicesState());

  Future<void> fetchSavedDevices() async {
    try {
      emit(state.copyWith(status: ApiStatusState.loading));

      final savedDevicesData = await fetchSavedDevicesResponse();

      if (savedDevicesData.data.isEmpty) {
        emit(state.copyWith(status: ApiStatusState.empty));
      } else {
        emit(state.copyWith(
          savedDevicesResponse: savedDevicesData,
          status: ApiStatusState.success,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        error: e.toString(),
        status: ApiStatusState.error,
      ));
    }
  }



  Future<void> fetchDevice() async {
    if (isClosed) return; // Prevent emitting when Cubit is closed

    emit(state.copyWith(deviceStatus: ApiStatusState.loading));

    try {
      final response = await fetchDeviceResponse();

      if (response.data.isEmpty) {
        emit(state.copyWith(deviceStatus: ApiStatusState.empty));
      } else {
        emit(state.copyWith(
          osResponse: response,
          deviceStatus: ApiStatusState.success,
        ));
      }
    } catch (e) {
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      Fluttertoast.showToast(msg: errorMessage);

      if (!isClosed) {
        emit(state.copyWith(deviceStatus: ApiStatusState.error));
      }
    }
  }
  Future<SavedDevicesResponse> fetchSavedDevicesResponse() async {
    try {
      final accesstoken =
          await Constants.prefs?.getString("provider_access_token");
      final updateMap = <String, dynamic>{
        'access_token': accesstoken,
      };

      FormData data = FormData.fromMap(updateMap);
      final dio = BaseApi().dioClient();

      final response = await dio.post('user_devices', data: data);

      if (response.data['err_code'] == "valid") {
        final results = response.data['data'];
        return SavedDevicesResponse.fromJson({'data': results});
      } else {
        throw (response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else {
          throw ("Unable to get saved devices");
        }
      } else {
        rethrow;
      }
    }
  }

  // 'device_type': deviceModelName.text,
  // 'order_id': widget.id,
  // 'brand': selectBrand.text,
  // 'model_name': modelName.text,
  // 'serial_number': serviceTag.text,
  updateDeviceDetails({required SavedDevice? savedDevice}) {
    emit(state.copyWith(savedDevice: savedDevice));
  }

  Future<void> addNewDevice(
      {required Map<String, dynamic> deviceInfo,
      required SavedDevice? savedDevice,
      required BuildContext context}) async {
    try {
      emit(state.copyWith(addStatus: ApiStatusState.loading));

      final addDeviceResponse = await addNewDeviceResponse(deviceInfo, context);

      if (addDeviceResponse == 'valid') {
        emit(state.copyWith(
            addStatus: ApiStatusState.success, savedDevice: savedDevice));
      } else {
        Fluttertoast.showToast(msg: addDeviceResponse.toString());
        emit(state.copyWith(
          addStatus: ApiStatusState.error,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      Fluttertoast.showToast(msg: e.toString());
      emit(state.copyWith(
        error: e.toString(),
        addStatus: ApiStatusState.error,
      ));
    }
  }


  Future<OSResponse> fetchDeviceResponse() async {
    try {
      final dio = BaseApi().dioClient();
      final response = await dio.post('customer/devicetypes');

      final data = response.data;

      if (data != null && data['status'] == true) {
        return OSResponse.fromJson(data);
      } else {
        throw Exception(data?['message'] ?? 'Unexpected response from server');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception('Unable to fetch device list. Please try again.');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
  Future<String> addNewDeviceResponse(
    Map<String, dynamic> deviceInfo,
    BuildContext context,
  ) async {
    try {
      final accessToken =
          await Constants.prefs?.getString("provider_access_token");
      //demo74.colormoon.in/device_doctors/api/user_devices/add_update
      final requestBody = {
        'access_token': accessToken,
        ...deviceInfo,
      };

      FormData formData = FormData.fromMap(requestBody);
      final dio = BaseApi().dioClient();

      final response = await dio.post('homeservices/vendor/orders/add_device',
          data: formData);

      if (response.data['err_code'] == "valid") {
        context.read<SavedDevicesCubit>().fetchSavedDevices();
        Navigator.pop(context);
        return response.data['err_code'];
      } else {
        throw (response.data['message']);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        } else {
          throw ("Unable to add new device");
        }
      } else {
        rethrow;
      }
    }
  }
}
