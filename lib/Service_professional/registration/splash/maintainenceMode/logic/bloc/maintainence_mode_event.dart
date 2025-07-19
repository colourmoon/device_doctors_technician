part of 'maintainence_mode_bloc.dart';

class MaintainenceModeEvent extends Equatable {
  const MaintainenceModeEvent();

  @override
  List<Object> get props => [];
}

class MaintainenceModeFetchEvent extends MaintainenceModeEvent {
  const MaintainenceModeFetchEvent();

  @override
  List<Object> get props => [];
}

class VersionCheckEvent extends MaintainenceModeEvent {
  const VersionCheckEvent();

  @override
  List<Object> get props => [];
}

class VersionSkipEvent extends MaintainenceModeEvent {
  const VersionSkipEvent();

  @override
  List<Object> get props => [];
}
