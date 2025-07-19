import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity _connectivity;
  ConnectivityCubit(this._connectivity)
      : super(ConnectivityStatus.disconnected) {
    _init();
  }
  void _init() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(ConnectivityStatus.disconnected);
      } else {
        emit(ConnectivityStatus.connected);
      }
    });
  }
}
