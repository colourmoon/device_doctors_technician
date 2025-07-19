part of 'cms_data_cubit.dart';

class CmsDataState extends Equatable {
  final bool? dataLoaded;
  final CmsDataModel? cmsData;
  final String cmsError;
  const CmsDataState(
      {this.dataLoaded = false, this.cmsData, this.cmsError = ''});

  @override
  List<Object?> get props => [dataLoaded, cmsData, cmsError];

  CmsDataState copyWith({
    bool? dataLoaded,
    CmsDataModel? cmsData,
    String? cmsError,
  }) {
    return CmsDataState(
        dataLoaded: dataLoaded ?? this.dataLoaded,
        cmsData: cmsData ?? this.cmsData,
        cmsError: cmsError ?? '');
  }
}
