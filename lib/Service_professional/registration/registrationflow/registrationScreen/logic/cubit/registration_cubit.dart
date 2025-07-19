import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:device_doctors_technician/Service_professional/commons/common_toast.dart';
import 'package:device_doctors_technician/comman/Api/end_points.dart';
import '../../../../../../comman/Api/Base-Api.dart';
import 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final Location location = Location();

  RegistrationCubit()
      : super(RegistrationState(
            isLoading: false, isError: false, registrationLoading: false));

  registerUser({required Map<String, dynamic> registrationData}) async {
    print("loading state i registration 22: ${state.registrationLoading}");
    emit(state.copyWith(registrationLoading: true));
    print("loading state i registration 33: ${state.registrationLoading}");
    try {
      print(registrationData);
      FormData data = await FormData.fromMap(registrationData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().registration_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          print(
              "loading state i registration 00: ${state.registrationLoading}");

          emit(state.copyWith(
              registrationLoading: false, registrationSuccess: "valid"));
          print(
              "loading state i registration 11: ${state.registrationLoading}");
        } else {
          emit(state.copyWith(
              registrationLoading: false, registrationfailed: res["message"]));

          print("${ApiEndPoints().registration_endpoint} responce: ${res}");
        }
      });
    } catch (e) {
      CommonToastwidget(toastmessage: e.toString());
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

  void fetchCurrentLocation() async {
    emit(state.copyWith(isLoading: true));

    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData? locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          emit(state.copyWith(isError: true));
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          emit(state.copyWith(isError: true));
          return;
        }
      }

      locationData = await location.getLocation();
      if (locationData != null) {
        // Reverse geocode location to get address
        print("location: ${locationData.latitude}");
        String? address = await _getAddressFromCoordinates(
            locationData.latitude!, locationData.longitude!);
        emit(state.copyWith(address: address, isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isError: true));
    }
  }

  Future<String?> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    // Implement your method to fetch address from coordinates, e.g., using Geocoding APIs
    // For demonstration purpose, returning dummy address
    return '123 Main St, City, Country';
  }
}
