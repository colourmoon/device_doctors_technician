part of 'service_details_cubit.dart';

class ServiceDetailsState {
  bool? isLoading;
  bool isStatusLoading;
  String? pinVerified;
  String? pinError;
  String? reachedSuccesss;
  final String? selectedOption;
  String? completeSuccesss;
  String? completeFailed;
  String? reachedFailed;
  ServiceDetailsModel? serviceDetails;
  bool? hasVisitAndQuote;
  String? error;
  ServiceDetailsState(
      {this.isLoading,
      this.isStatusLoading = false,
      this.pinError,
      this.pinVerified,
      this.selectedOption,
      this.reachedFailed,
      this.completeSuccesss,
      this.completeFailed,
      this.reachedSuccesss,
      this.serviceDetails,
      this.hasVisitAndQuote,
      this.error});

  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isStatusLoading,
    String? reachedSuccesss,
    String? completeSuccesss,
    String? completeFailed,
    String? selectedOption,
    String? reachedFailed,
    String? pinVerified,
    String? pinError,
    ServiceDetailsModel? serviceDetails,
    bool? hasVisitAndQuote,
    String? error,
  }) {
    return ServiceDetailsState(
        isLoading: isLoading ?? this.isLoading,
        reachedSuccesss: reachedSuccesss ?? this.reachedSuccesss,
        pinError: pinError ?? this.pinError,
        pinVerified: pinVerified ?? this.pinVerified,
        reachedFailed: reachedFailed ?? this.reachedFailed,
        selectedOption: selectedOption ?? this.selectedOption,
        completeFailed: completeFailed ?? completeFailed,
        completeSuccesss: completeSuccesss ?? completeSuccesss,
        isStatusLoading: isStatusLoading ?? this.isStatusLoading,
        serviceDetails: serviceDetails ?? this.serviceDetails,
        hasVisitAndQuote: hasVisitAndQuote ?? this.hasVisitAndQuote,
        error: error ?? this.error);
  }
}
