part of 'all_orders_cubit.dart';

class AllOrdersState extends Equatable {
  final bool dataLoading;
  final AllOrderType allOrderType;
  final AllOrdersListModel? loadMoreOrderList;
  final String? error;
  final DateTimeRange? dateRange;
  final bool? dateFetched;
  final bool isNewValueSelected;

  const AllOrdersState({
    this.dataLoading = false,
    this.loadMoreOrderList,
    this.error,
    this.dateRange,
    this.dateFetched,
    this.allOrderType =AllOrderType.accepted,
    this.isNewValueSelected = false,
  });
  bool get loadMoreRidesListNotAvailable =>
      loadMoreOrderList == null || (loadMoreOrderList?.results.isEmpty == true);
  @override
  List<Object?> get props => [
        dataLoading,
        loadMoreOrderList,
        error,
        dateRange,
        dateFetched,
        allOrderType,
        isNewValueSelected
      ];
  AllOrdersState copyWith({
    bool? dataLoading,
    AllOrderType? allOrderType,
    String? error,
    bool? dateFetched,
    bool? isNewValueSelected,
    AllOrdersListModel? loadMoreOrderList,
    DateTimeRange? dateRange, bool cleanRange = false
  }) {
    return AllOrdersState(
      dataLoading: dataLoading ?? this.dataLoading,
      allOrderType: allOrderType ?? this.allOrderType,
      error: error ?? this.error,
      dateFetched: dateFetched ?? this.dateFetched,
      dateRange: cleanRange?null:dateRange ?? this.dateRange,
      isNewValueSelected: isNewValueSelected ?? this.isNewValueSelected,
      loadMoreOrderList: loadMoreOrderList ?? this.loadMoreOrderList,
    );
  }

}
