part of 'maintainence_mode_bloc.dart';

class MaintainenceModeState extends Equatable {
  const MaintainenceModeState();

  @override
  List<Object> get props => [];
}

class MaintainenceModeInitial extends MaintainenceModeState {}

class MaintainenceModeLoading extends MaintainenceModeState {}

class MaintainenceModeFetched extends MaintainenceModeState {
  const MaintainenceModeFetched({required this.maintainancemoderes});
  final MaintainanceModel maintainancemoderes;
  @override
  List<Object> get props => [maintainancemoderes];
}

class MaintainenceModeError extends MaintainenceModeState {}

class VersionCheckState extends MaintainenceModeState {
  final VersionCheckModel versionCheckRes;
  VersionCheckState({required this.versionCheckRes});
  @override
  List<Object> get props => [versionCheckRes];
}

class VersionCheckErrorState extends MaintainenceModeState {}

class VersionCheckSkipState extends MaintainenceModeState {}
