part of 'services_cubit.dart';

class ServicesState {
  bool? isLoading;
  bool? statusUpdatedSuccess;
  List<ServicesModel> servicesList;
  String? selectedServiceId;
  String? error;

  ServicesState(
      {required this.servicesList,
      this.isLoading,
      this.statusUpdatedSuccess,
      this.selectedServiceId,
      this.error});

  // @override
  // List<Object> get props => [servicesList];
  ServicesState copyWith(
      {List<ServicesModel>? servicesList,
      bool? isLoading,
      String? selectedServiceId,
      String? error,
      bool? statusUpdatedSuccess}) {
    return ServicesState(
        statusUpdatedSuccess: statusUpdatedSuccess ?? false,
        servicesList: servicesList ?? this.servicesList,
        selectedServiceId: selectedServiceId ?? this.selectedServiceId,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading);
  }
}
