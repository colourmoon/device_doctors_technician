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
  final ApiStatusState deviceStatus;
  final String? error;
  final SavedDevice? savedDevice;
  final SavedDevicesResponse? savedDevicesResponse;
  final OSResponse? osResponse;

  const SavedDevicesState({
    this.status = ApiStatusState.loading,
    this.deviceStatus = ApiStatusState.loading,
    this.addStatus = ApiStatusState.empty,
    this.error,
    this.savedDevice,
    this.savedDevicesResponse,
    this.osResponse,
  });

  @override
  List<Object?> get props => [status, error, savedDevicesResponse,addStatus,savedDevice,deviceStatus,osResponse];

  SavedDevicesState copyWith({
    ApiStatusState? deviceStatus,
    ApiStatusState? status,
    ApiStatusState? addStatus,
    String? error,SavedDevice? savedDevice,
    SavedDevicesResponse? savedDevicesResponse,
    OSResponse? osResponse,
  }) {
    return SavedDevicesState(
      status: status ?? this.status,
      addStatus: addStatus ?? this.addStatus,
      savedDevice: savedDevice ?? this.savedDevice,
      deviceStatus: deviceStatus ?? this.deviceStatus,
      osResponse: osResponse ?? this.osResponse,
      error: error,
      savedDevicesResponse:
      savedDevicesResponse ?? this.savedDevicesResponse,
    );
  }
}
