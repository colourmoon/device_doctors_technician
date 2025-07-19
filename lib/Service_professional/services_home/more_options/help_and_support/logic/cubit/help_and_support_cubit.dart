import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/help_support_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/more_options_repository.dart';

part 'help_and_support_state.dart';

class HelpAndSupportCubit extends Cubit<HelpAndSupportState> {
  HelpAndSupportCubit() : super(HelpAndSupportState());

  submitFile(File file, String type, describeIssue, orderId) async {
    try {
      emit(state.copyWith(
        submitSupportSuccess: true,
      ));
      final fileData = await MoreOptionsRepository()
          .submitHelSupport(file, type, describeIssue, orderId);
      emit(state.copyWith(submitSupportSuccess: false));
    } catch (e) {
      print("Cache error $e");
      emit(state.copyWith());
    }
  }

  Future<void> fetchRaisedIssue(type) async {
    try {
      emit(state.copyWith(dataLoaded: true));
      final referalList = await MoreOptionsRepository().fetchRaisedIssue(type);
      emit(state.copyWith(helpSupportList: referalList, dataLoaded: false));
    } catch (e) {
      print('ERROR FETCHING Issue $e');
      emit(state.copyWith(helpSupportError: e.toString(), dataLoaded: false));
    }
  }
}
