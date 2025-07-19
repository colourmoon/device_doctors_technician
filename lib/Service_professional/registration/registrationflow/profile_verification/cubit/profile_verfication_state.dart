part of 'profile_verfication_cubit.dart';

class ProfileVerficationState {
  bool? isLoading;
  ProfileVerficationModel? verificationModel;
  bool error;

  ProfileVerficationState(
      {this.isLoading, this.verificationModel, this.error = false});

  ProfileVerficationState copyWith(
      {bool? isLoading,
      ProfileVerficationModel? verificationModel,
      bool? error}) {
    return ProfileVerficationState(
        isLoading: isLoading ?? this.isLoading,
        verificationModel: verificationModel ?? this.verificationModel,
        error: error ?? false);
  }
}
