import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/refer_list_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/more_options_repository.dart';

part 'referral_list_state.dart';

class ReferralListCubit extends Cubit<ReferralListState> {
  ReferralListCubit() : super(const ReferralListState());

  Future<void> fetchReferralList() async {
    try {
      emit(state.copyWith(listStatus: CurrentRequestStatus.loading));

      final referalList = await MoreOptionsRepository().fetchReferralList();
      if (referalList.errCode == "valid") {
        emit(state.copyWith(
            referList: referalList,
            listStatus: CurrentRequestStatus.success));
      } else {
        print("_______________________${referalList.toString()}");
        emit(state.copyWith(
          listStatus: CurrentRequestStatus.error,
          referralError: 'No data found',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
          referralError: e.toString(), listStatus: CurrentRequestStatus.error));
    }
  }

  Future<void> submitReferral(name, mobile, age, service, address) async {
    try {
      emit(state.copyWith(referalSubmitSuccess: true));

      final referalList = await MoreOptionsRepository()
          .submitReferral(name, mobile, age, service, address);
      emit(state.copyWith(referalSubmitSuccess: false));
    } catch (e) {
      print('ERROR FETCHING Referral $e');
      emit(state.copyWith(referalSubmitSuccess: false));
    }
  }
}