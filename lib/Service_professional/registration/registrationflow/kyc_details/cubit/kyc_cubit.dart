import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';
import '../../../../commons/common_toast.dart';
import '../../registrationScreen/repository/registration_repo.dart';

import 'package:dio/dio.dart';
part 'kyc_state.dart';

class KycCubit extends Cubit<KycState> {
  KycCubit() : super(KycState());

  kycSubmit(adhaarCardFront, adhaarCardBack, panCard) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      FormData formData = FormData.fromMap({
        'access_token': Constants.prefs?.getString("provider_access_token"),
        if(adhaarCardFront != 'null')
        'adhaar_card_front': adhaarCardFront,
        if(adhaarCardBack != 'null')
        'adhaar_card_back': adhaarCardBack,
        if(panCard != 'null')
        'pan_card': panCard
      });
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().kycUpdate, data: formData)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          CommonSuccessToastwidget(toastmessage: res["message"]);
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          emit(state.copyWith(isLoading: false, Success: "valid"));
        } else {
          CommonToastwidget(toastmessage: res["message"]);
          emit(state.copyWith(isLoading: false, failed: res["message"]));

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
}
