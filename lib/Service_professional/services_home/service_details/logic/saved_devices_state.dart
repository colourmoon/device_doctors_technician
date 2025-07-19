part of 'saved_devices_cubit.dart';

enum ApiStatusState {
  loading,
  init,
  success,
  error,
  empty,
  cancel,
}


class SavedDevicesState extends Equatable {
  final ApiStatusState status;
  final ApiStatusState addStatus;
  final String? error;
  final SavedDevice? savedDevice;
  final SavedDevicesResponse? savedDevicesResponse;

  const SavedDevicesState({
    this.status = ApiStatusState.loading,
    this.addStatus = ApiStatusState.empty,
    this.error,
    this.savedDevice,
    this.savedDevicesResponse,
  });

  @override
  List<Object?> get props => [status, error, savedDevicesResponse,addStatus,savedDevice];

  SavedDevicesState copyWith({
    ApiStatusState? status,
    ApiStatusState? addStatus,
    String? error,SavedDevice? savedDevice,
    SavedDevicesResponse? savedDevicesResponse,
  }) {
    return SavedDevicesState(
      status: status ?? this.status,
      addStatus: addStatus ?? this.addStatus,
      savedDevice: savedDevice ?? this.savedDevice,
      error: error,
      savedDevicesResponse:
      savedDevicesResponse ?? this.savedDevicesResponse,
    );
  }
}
