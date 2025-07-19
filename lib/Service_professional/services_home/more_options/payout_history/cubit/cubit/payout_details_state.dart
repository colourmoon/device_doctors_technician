part of 'payout_details_cubit.dart';

class PayoutDetailsState extends Equatable {
  const PayoutDetailsState();

  @override
  List<Object> get props => [];
}

class PayoutDetailsInitial extends PayoutDetailsState {}

class PayoutDetailsLoading extends PayoutDetailsState {}

class PayoutDetailsFetched extends PayoutDetailsState {
  final PayoutsDetailsModel payoutDetails;
  PayoutDetailsFetched({required this.payoutDetails});

  @override
  List<Object> get props => [payoutDetails];
}

class PayoutDetailsError extends PayoutDetailsState {
  final String error;
  PayoutDetailsError({required this.error});

  @override
  List<Object> get props => [error];
}
