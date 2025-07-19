part of 'bank_details_cubit.dart';

class BankDetailsState {
  bool? isLoading;
  bool? detailsLoading;
  BankDetailsModel? fetchedDetails;
  String? Success;
  String? failed;
  BankDetailsState(
      {this.isLoading,
      this.Success,
      this.failed,
      this.fetchedDetails,
      this.detailsLoading});

  BankDetailsState copyWith({
    bool? isLoading,
    bool? detailsLoading,
    BankDetailsModel? fetchedDetails,
    String? Success,
    String? failed,
  }) {
    return BankDetailsState(
        isLoading: isLoading ?? this.isLoading,
        detailsLoading: detailsLoading ?? this.detailsLoading,
        fetchedDetails: fetchedDetails,
        Success: Success ?? this.Success,
        failed: failed ?? failed);
  }
}
