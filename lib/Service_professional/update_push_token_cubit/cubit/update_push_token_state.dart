part of 'update_push_token_cubit.dart';

class UpdatePushTokenState {
  bool? isLoading;
  bool? PushTokenUpdated;
  UpdatePushTokenState({this.PushTokenUpdated, this.isLoading});

  UpdatePushTokenState copyWith({
    bool? isLoading,
    bool? PushTokenUpdated,
  }) {
    return UpdatePushTokenState(
        isLoading: isLoading ?? this.isLoading,
        PushTokenUpdated: PushTokenUpdated ?? this.PushTokenUpdated);
  }
}
