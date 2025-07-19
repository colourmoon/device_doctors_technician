part of 'service_categories_cubit.dart';

class ServiceCategoriesState {
  final bool? isLoading;
  final bool? searchLoading;
  final List<ServiceCategoriesModel> serviceCategoriesList;
  final List<ServiceCategoriesModel> selectedCategoriesList;
  final String? error;
  ServiceCategoriesState({
    this.isLoading,
    this.searchLoading,
    required this.serviceCategoriesList,
    required this.selectedCategoriesList,
    this.error,
  });

  ServiceCategoriesState copyWith({
    bool? isLoading,
    bool? searchLoading,
    List<ServiceCategoriesModel>? serviceCategoriesList,
    List<ServiceCategoriesModel>? selectedCategoriesList,
    String? error,
  }) {
    return ServiceCategoriesState(
        isLoading: isLoading ?? this.isLoading,
        searchLoading: searchLoading ?? this.searchLoading,
        serviceCategoriesList:
            serviceCategoriesList ?? this.serviceCategoriesList,
        selectedCategoriesList:
            selectedCategoriesList ?? this.selectedCategoriesList,
        error: error ?? this.error);
  }
}
