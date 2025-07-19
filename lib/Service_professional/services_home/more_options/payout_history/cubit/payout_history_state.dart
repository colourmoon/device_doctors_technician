part of 'payout_history_cubit.dart';

class PayoutHistoryState extends Equatable {
  final bool dataLoading;
  final String value;
  final PayoutsListModel? loadMoreOrderList;
  final String? error;
  final DateTimeRange? dateRange;
  final bool? dateFetched;
  final bool isNewValueSelected;

  PayoutHistoryState(
      {this.dataLoading = false,
      this.loadMoreOrderList,
      this.error,
      required this.value,
      required this.isNewValueSelected,
      this.dateRange,
      this.dateFetched});
  bool get loadMoreRidesListNotAvailable =>
      loadMoreOrderList == null || loadMoreOrderList!.results.isEmpty;

  @override
  List<Object?> get props => [
        dataLoading,
        loadMoreOrderList,
        error,
        dateRange,
        dateFetched,
        value,
        isNewValueSelected
      ];
  PayoutHistoryState copyWith({
    bool? dataLoading,
    String? value,
    String? error,
    bool? dateFetched,
    bool? isNewValueSelected,
    PayoutsListModel? loadMoreOrderList,
    DateTimeRange? dateRange,
  }) {
    return PayoutHistoryState(
        dataLoading: dataLoading ?? false,
        value: value ?? this.value,
        error: error,
        dateFetched: dateFetched ?? this.dateFetched,
        dateRange: dateRange ?? this.dateRange,
        isNewValueSelected: isNewValueSelected ?? this.isNewValueSelected,
        loadMoreOrderList: loadMoreOrderList ?? this.loadMoreOrderList);
  }
}
