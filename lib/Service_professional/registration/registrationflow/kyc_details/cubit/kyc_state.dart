part of 'kyc_cubit.dart';

class KycState extends Equatable {
  bool? isLoading;
  String? Success;
  String? failed;
  KycState({
    this.isLoading,
    this.Success,
    this.failed,
  });

  @override
  List<Object?> get props => [isLoading, Success, failed];

  KycState copyWith({
    bool? isLoading,
    String? Success,
    String? failed,
  }) {
    return KycState(
        isLoading: isLoading ?? this.isLoading,
        Success: Success ?? this.Success,
        failed: failed ?? failed);
  }
}
