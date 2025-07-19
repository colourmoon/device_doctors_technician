import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';

import '../../../Notification/firebase_messaging/notification_device_token.dart';
import '../../../comman/Api/Base-Api.dart';
import '../../../comman/Api/end_points.dart';
import '../../../utility/auth_shared_pref.dart';
part 'update_push_token_state.dart';

class UpdatePushTokenCubit extends Cubit<UpdatePushTokenState> {
  UpdatePushTokenCubit() : super(UpdatePushTokenState());
  updatePushNotificationToken() async {
    final firebaseDeviceToken =
        await NotificationDeviceToken(FirebaseMessaging.instance).getDeviceToken();
    log(firebaseDeviceToken.toString(),name: "device_doctor_technication");
    emit(state.copyWith(isLoading: true));
    try {
      final updateMap = <String, dynamic>{
        'access_token':
            Constants.prefs?.getString("provider_access_token"),
        'push_notification_token': firebaseDeviceToken
      };
      FormData data = FormData.fromMap(updateMap);

      print(data.fields);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().update_token_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;

        print('>>>>>>>>>>>>>> token:${res}');
        print(jsonEncode(response.data));
        if (res['err_code'] == "valid") {
          emit(state.copyWith(PushTokenUpdated: true));
          print(res['message']);
          return res['message'];
        } else {
          emit(state.copyWith(PushTokenUpdated: false));

          throw (res['message']);
        }
      });
    } catch (e) {
      emit(state.copyWith(PushTokenUpdated: false));

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
