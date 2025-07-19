import '../../../../../comman/Api/Base-Api.dart';
import '../../../../../comman/Api/end_points.dart';
import '../../../../../utility/auth_shared_pref.dart';

import 'package:dio/dio.dart';

class RegistrationRepository extends BaseApi {
  final accessToken = Constants.prefs?.getString("provider_access_token");
  Future<dynamic> kycUpdate(adhaarCardFront, adhaarCardBack, panCard) async {
    try {
      FormData formData = FormData.fromMap({
        'access_token': accessToken,
        'adhaar_card_front': adhaarCardFront,
        'adhaar_card_back': adhaarCardBack,
        'pan_card': panCard
      });
      final dio = dioClient();
      print(formData.fields);

      return await dio
          .post(ApiEndPoints().kycUpdate, data: formData)
          .then((response) {
        if (response.data['err_code'] == "valid") {
          print(response.data);
          return response.data;
        }
      });
    } catch (e) {
      print(e);
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ("Unable to connect to the server at this time. Please try again");
        }
      }
      rethrow;
    }
  }
}
