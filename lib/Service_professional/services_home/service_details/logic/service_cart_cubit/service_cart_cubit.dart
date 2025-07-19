import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import '../../../../../utility/themeToast.dart';
part 'service_cart_state.dart';


class ServiceCartCubit extends Cubit<ServiceCartState> {
  ServiceCartCubit() : super(ServiceCartState());
  clean()=>   emit(state.copyWith(selectedDate: ServiceDate(
    id: -1,
    value: '',
    month: '',
    day: '',
    displayValue: '',
  )));

  void setSelectedDate(ServiceDate data,{bool isAMCTimeSlot = false}) {
    emit(state.copyWith(selectedDate: data));
    fetchTimeList(data.value,isAMCTimeSlot: isAMCTimeSlot);
  }
  void setAddressSet(bool isSet) {
    emit(state.copyWith(isAddressVisible: isSet));
  }

  void setSelectedType(String type) {
    emit(state.copyWith(selectedType: type));
  }


  Future<void> fetchTimeList(date,{bool isAMCTimeSlot = false}) async {
    try {
      emit(state.copyWith(timeLoader: true));
      final timeData = await ServiceCartRepository().fetchTimeList(date,isAMCTimeSlot: isAMCTimeSlot);

      emit(state.copyWith(
          timeList: timeData, timeLoader: false, selectedTime: ''));
    } catch (e) {
      emit(state.copyWith(timeLoader: false));
      print('ERROR FETCHING DateList $e');
      ThemeToast().ErrorToast(e.toString());
    }
  }

  void setTemporaryTime(String time) {
    emit(state.copyWith(temSelectedTime: time));
  }

  void setSelectedTime(String time) {
    emit(state.copyWith(
      selectedTime: time,
    ));
  }

  Future<void> fetchDateList() async {
    try {
      emit(state.copyWith(dateLoader: false));
      final dateData = await ServiceCartRepository().fetchDateList();

      emit(state.copyWith(
          dateList: dateData,
          dateLoader: true,
          selectedDate: dateData.data[0]));
      fetchTimeList(dateData.data[0].value);
    } catch (e) {
      print('ERROR FETCHING DateList $e');
      ThemeToast().ErrorToast(e.toString());
    }
  }


  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage1FromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(image1: pickedFile));
      context.read<ServiceCartCubit>().uploadImage(
        pickedFile: pickedFile,
        imageType: "image1", // or "image2"
      );
    }
  }

  Future<void> pickImage2FromGallery(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(image2: pickedFile));
      context.read<ServiceCartCubit>().uploadImage(
        pickedFile: pickedFile,
        imageType: "image2", // or "image2"
      );

    }
  }

  Future<void> uploadImage({
    required XFile pickedFile,
    required String imageType, // "image1" or "image2"
  }) async {
    try {
       if (pickedFile == null) {
        ThemeToast().ErrorToast("No file selected");
        return;
      }

      final fileName = pickedFile.path.split('/').last;
      final data = dio.FormData.fromMap({
        "image": await dio.MultipartFile.fromFile(
          pickedFile.path,
          filename: fileName,
        )
      });

      final response = await BaseApi().dioClient().post(
        ApiEndPoints.servergUrl + ApiEndPoints.imageUploadService,
        data: data,
      );

      if (response.data['err_code'] == "invalid") {
        ThemeToast().ErrorToast(response.data['message']);
      }

      if (response.data['err_code'] == "valid") {
        final uploadedPath = response.data['data'];

        if (imageType == "image1") {
          emit(state.copyWith(
            image1: pickedFile,
            uploadedImage1Path: uploadedPath,
          ));
        } else if (imageType == "image2") {
          emit(state.copyWith(
            image2: pickedFile,
            uploadedImage2Path: uploadedPath,
          ));
        }

        ThemeToast().SuccessToast("Image uploaded successfully");
      }
    } catch (e) {
      ThemeToast().ErrorToast("Failed to upload image");
      print("Upload Error: $e");
    }
  }

  Future<void> rescheduleCurrentOrder({
    required String orderId,
    required String remarks,
      Function? success,
  }) async {
    try {
      final token = await Constants.prefs?.getString("provider_access_token") ?? '';
      final date = state.selectedDate?.value ?? '';
      final time = state.selectedTime;
      final image1 = state.uploadedImage1Path;
      final image2 = state.uploadedImage2Path;

      emit(state.copyWith(rescheduling: true));

      final apiSuccess = await ServiceCartRepository().rescheduleOrder(
        accessToken: token,
        orderId: orderId,
        selectedDate: date,
        selectedTime: time,
        rescheduleRemarks: remarks,
        image1: image1,
        image2: image2,
      );

      if (apiSuccess) {
        ThemeToast().SuccessToast("Rescheduled successfully");
        success?.call();
      }

      emit(state.copyWith(rescheduling: false));
    } catch (e) {
      ThemeToast().ErrorToast(e.toString());
      emit(state.copyWith(rescheduling: false));
    }
  }


}




class ServiceCartRepository {

  Future<DateListModel> fetchDateList() async {
    try {
      FormData data = FormData.fromMap({
        'access_token':  Constants.prefs?.getString("provider_access_token"),
      });
      print(data.fields);
      final dio = BaseApi().dioClient();
      return await dio
          .post("homeservices/datetimes_slots/dates", data: data)
          .then((response) {
        print(response);
        if (response.data['err_code'] == "valid") {
          return DateListModel.fromJson(response.data);
        } else {
          return DateListModel(
            errCode: response.data['err_code'],
            data: [],
          );
          // throw (response.data['message']);
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        }
      }
      rethrow;
    }
  }

  Future<TimeListModel> fetchTimeList(date,
      {bool isAMCTimeSlot = false}) async {
    try {
      final accessToken = await Constants.prefs?.getString("provider_access_token");

      FormData data = FormData.fromMap({
        'access_token': accessToken,
        'date': date,
      });
      print(data.fields);
      final dio =  BaseApi().dioClient();
      return await dio
          .post(
          "homeservices/Datetimes_slots/time_slots_amc",
          data: data)
          .then((response) {
        print(response);
        if (response.data['err_code'] == "valid") {
          return TimeListModel.fromJson(response.data);
        } else {
          return TimeListModel(
            errCode: response.data['err_code'],
            data: [],
          );
        }
      });
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Server error");
        }
      }
      rethrow;
    }
  }

  Future<bool> rescheduleOrder({
    required String accessToken,
    required String orderId,
    required String selectedDate,
    required String selectedTime,
    required String rescheduleRemarks,
    required String image1,
    required String image2,
  }) async {
    try {
      final dio = BaseApi().dioClient();

      final formData = FormData.fromMap({
        'access_token': accessToken,
        'order_id': orderId,
        'selected_date': selectedDate,
        'selected_time': selectedTime,
        'rescheduled_remarks': rescheduleRemarks,
        'image1': image1,
        'image2': image2,
      });

      final response = await dio.post(
        "homeservices/vendor/orders/reschedule_order",
        data: formData,
      );

      if (response.data['err_code'] == "valid") {
        // Optionally return the message if needed
        return true;
      } else {
        throw response.data['message'] ?? "Reschedule failed";
      }
    } catch (e) {
      print('Reschedule API error: $e');
      throw "Something went wrong while rescheduling";
    }
  }


}



DateListModel dateListModelFromJson(String str) =>
    DateListModel.fromJson(json.decode(str));

String dateListModelToJson(DateListModel data) => json.encode(data.toJson());

class DateListModel {
  String errCode;
  List<ServiceDate> data;

  DateListModel({
    required this.errCode,
    required this.data,
  });

  factory DateListModel.fromJson(Map<String, dynamic> json) => DateListModel(
    errCode: json["err_code"],
    data: List<ServiceDate>.from(
        json["data"].map((x) => ServiceDate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "err_code": errCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ServiceDate {
  int id;
  String value;
  String month;
  String day;
  String displayValue;

  ServiceDate({
    required this.id,
    required this.value,
    required this.month,
    required this.day,
    required this.displayValue,
  });

  factory ServiceDate.fromJson(Map<String, dynamic> json) => ServiceDate(
      id: json['id'] ?? "",
      value: json["value"] ?? "",
      month: json["month"] ?? "",
      day: json["day"] ?? "",
      displayValue: json['display_value'] ?? "");

  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "month": month,
    "day": day,
    'display_value': displayValue
  };
}

TimeListModel timeListModelFromJson(String str) =>
    TimeListModel.fromJson(json.decode(str));

String timeListModelToJson(TimeListModel data) => json.encode(data.toJson());

class TimeListModel {
  String errCode;
  List<TimeList> data;

  TimeListModel({
    required this.errCode,
    required this.data,
  });

  factory TimeListModel.fromJson(Map<String, dynamic> json) => TimeListModel(
    errCode: json["err_code"],
    data:
    List<TimeList>.from(json["data"].map((x) => TimeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "err_code": errCode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TimeList {
  int id;
  String time;

  TimeList({
    required this.id,
    required this.time,
  });

  factory TimeList.fromJson(Map<String, dynamic> json) => TimeList(
    id: json["id"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "time": time,
  };
}
