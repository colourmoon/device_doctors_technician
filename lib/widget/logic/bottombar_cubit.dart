import 'package:bloc/bloc.dart';

import 'bottombar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarInitialStates()) {
    reloadState() {
      emit(BottomBarLoadingStates());
    }
  }
}
