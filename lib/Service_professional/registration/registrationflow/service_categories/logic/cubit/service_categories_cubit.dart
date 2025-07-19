import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../comman/Api/Base-Api.dart';
import '../../../../../../comman/Api/end_points.dart';
import '../../../../../commons/common_toast.dart';
import '../../model/service_categories_model.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
part 'service_categories_state.dart';

class ServiceCategoriesCubit extends Cubit<ServiceCategoriesState> {
  ServiceCategoriesCubit()
      : super(ServiceCategoriesState(
            serviceCategoriesList: [], selectedCategoriesList: []));
  fetchServiceCategories({required searchKey}) async {
    if (searchKey == "") {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(searchLoading: true));
    }

    try {
      print(searchKey);
      Map<String, dynamic> bodyData = {};
      if (searchKey != "") {
        bodyData = {"keyword": searchKey};
      }

      FormData data = await FormData.fromMap(bodyData);
      final dio = BaseApi().dioClient();
      return await dio
          .post(ApiEndPoints().categories_endpoint, data: data)
          .then((response) {
        dynamic res = response.data;
        if (res["err_code"] == "valid") {
          // print("${ApiEndPoints().registration_endpoint} responce: ${res}");
          List<ServiceCategoriesModel> categoriesList = [];
          for (int i = 0; i < res["data"].length; i++) {
            categoriesList.add(ServiceCategoriesModel.fromJson(res["data"][i]));
            if (state.selectedCategoriesList
                .contains(categoriesList[i].title)) {
              categoriesList[i].isSelected = true;
            }
          }
          if (searchKey == "") {
            emit(state.copyWith(
                isLoading: false, serviceCategoriesList: categoriesList));
          } else {
            emit(state.copyWith(
                searchLoading: false, serviceCategoriesList: categoriesList));
          }
        } else {
          emit(state.copyWith(
              isLoading: false, searchLoading: false, error: res["message"]));

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

  selectService(int index) {
    final currentstate = state;
    final itemsList = state.serviceCategoriesList;
    itemsList[index].isSelected = !itemsList[index].isSelected;
    state.selectedCategoriesList.clear();
    itemsList.forEach((element) {
      if (element.isSelected == true) {
        state.selectedCategoriesList
            .add(ServiceCategoriesModel(id: element.id, title: element.title));
      }
    });
    emit(currentstate.copyWith(
      serviceCategoriesList: itemsList,
    ));
  }
}
