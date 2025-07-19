import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/cms_data_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/more_options_repository.dart';

part 'cms_data_state.dart';

class CmsDataCubit extends Cubit<CmsDataState> {
  CmsDataCubit() : super(CmsDataState());

  Future<void> fetchCmsData(type) async {
    try {
      emit(state.copyWith(dataLoaded: false));

      final referalList = await MoreOptionsRepository().fetchCmsData(type);
      emit(state.copyWith(cmsData: referalList, dataLoaded: true));
    } catch (e) {
      print('ERROR FETCHING Referral $e');
      emit(state.copyWith(cmsError: e.toString(), dataLoaded: true));
    }
  }
}
