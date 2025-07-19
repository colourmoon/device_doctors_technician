part of 'help_and_support_cubit.dart';

class HelpAndSupportState extends Equatable {
  final bool submitSupportSuccess;
  final bool dataLoaded;
  final HelpSupportListModel? helpSupportList;
  final String helpSupportError;
  const HelpAndSupportState(
      {this.submitSupportSuccess = false,
      this.dataLoaded = false,
      this.helpSupportList,
      this.helpSupportError = ''});

  @override
  List<Object?> get props =>
      [submitSupportSuccess, dataLoaded, helpSupportList, helpSupportError];

  HelpAndSupportState copyWith(
      {bool? submitSupportSuccess,
      bool? dataLoaded,
      HelpSupportListModel? helpSupportList,
      String? helpSupportError}) {
    return HelpAndSupportState(
        submitSupportSuccess: submitSupportSuccess ?? false,
        dataLoaded: dataLoaded ?? this.dataLoaded,
        helpSupportList: helpSupportList ?? this.helpSupportList,
        helpSupportError: helpSupportError ?? '');
  }
}
