part of 'referral_list_cubit.dart';

class ReferralListState extends Equatable {
  final CurrentRequestStatus? listStatus;
  final ReferListModel? referList;
  final String referralError;
  final bool? referalSubmitSuccess;

  const ReferralListState(
      {this.listStatus = CurrentRequestStatus.loading,
        this.referList,
        this.referralError = '',
        this.referalSubmitSuccess = false});

  @override
  List<Object?> get props =>
      [listStatus, referList, referralError, referalSubmitSuccess];

  ReferralListState copyWith(
      {CurrentRequestStatus? listStatus,
        ReferListModel? referList,
        String? referralError,
        bool? referalSubmitSuccess}) {
    return ReferralListState(
        listStatus: listStatus ?? this.listStatus,
        referList: referList ?? this.referList,
        referralError: referralError ?? '',
        referalSubmitSuccess: referalSubmitSuccess ?? false);
  }
}

enum CurrentRequestStatus { loading, success, error, empty, init }
// initial
