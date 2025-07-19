part of 'profile_cubit.dart';

class ProfileState {
  bool? isLoading;
  bool? fetchLoading;
  ProfileDetailsFetchingModel? profileDetils;
  bool? StatusUpdateSuccess;

  ProfileState(
      {this.StatusUpdateSuccess,
      this.isLoading,
      this.profileDetils,
      this.fetchLoading});

  ProfileState copyWith({
    bool? isLoading,
    bool? fetchLoading,
    ProfileDetailsFetchingModel? profileDetils,
    bool? StatusUpdateSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      fetchLoading: fetchLoading ?? this.fetchLoading,
      profileDetils: profileDetils ?? this.profileDetils,
      StatusUpdateSuccess: StatusUpdateSuccess ?? this.StatusUpdateSuccess,
    );
  }
}
