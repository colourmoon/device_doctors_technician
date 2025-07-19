import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/maintainance_mode_model.dart';
import '../../model/version_check_model.dart';
import '../../repository/maintainance_repo.dart';

part 'maintainence_mode_event.dart';
part 'maintainence_mode_state.dart';

class MaintainenceModeBloc
    extends Bloc<MaintainenceModeEvent, MaintainenceModeState> {
  MaintainanceModeRepository maintinanceRepo;
  MaintainenceModeBloc({required this.maintinanceRepo})
      : super(MaintainenceModeInitial()) {
    on<MaintainenceModeEvent>((event, emit) async {
      // if (event is MaintainenceModeFetchEvent) {
      //   try {
      //     final MaintainanceModel responce =
      //         await maintinanceRepo.MaintainanceModeApi();
      //     emit(MaintainenceModeFetched(maintainancemoderes: responce));
      //   } catch (e) {
      //     emit(MaintainenceModeError());
      //     print(e);
      //   }
      // }
      if (event is VersionSkipEvent) {
        emit(VersionCheckSkipState());
      }

      if (event is VersionCheckEvent) {
        try {
          final VersionCheckModel res = await maintinanceRepo.VersionCheckApi();
          emit(VersionCheckState(versionCheckRes: res));
        } catch (e) {
          emit(VersionCheckErrorState());
          print(e);
        }
      }

      // TODO: implement event handler
    });
  }
}
