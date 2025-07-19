part of 'new_orders_cubit.dart';

class NewOrdersState {
  bool? isLoading;
  List<NewOrderModel>? newOrder;
  bool? hasVisitAndQuote;

  bool? ordersFetched;
  String? error;
  String? acceptOrderSuccess;
  String? acceptOrderFailed;
  String? rejectOrderSuccess;
  String? rejectOrderFailed;
  NewOrdersState({
    this.newOrder,
    this.ordersFetched,
    this.isLoading,
    this.error,
    this.acceptOrderFailed,
    this.hasVisitAndQuote,
    this.acceptOrderSuccess,
    this.rejectOrderSuccess,
    this.rejectOrderFailed,
  });

  NewOrdersState copyWith({
    bool? isLoading,
    List<NewOrderModel>? newOrder,
    bool? hasVisitAndQuote,
    bool? ordersFetched,
    String? error,
    String? acceptOrderFailed,
    String? acceptOrderSuccess,
    String? rejectOrderSuccess,
    String? rejectOrderFailed,
  }) {
    return NewOrdersState(
        isLoading: isLoading ?? this.isLoading,
        newOrder: newOrder ?? null,
        ordersFetched: ordersFetched ?? this.ordersFetched,
        error: error ?? this.error,
        acceptOrderFailed: acceptOrderFailed ?? null,
        acceptOrderSuccess: acceptOrderSuccess ?? null,
        hasVisitAndQuote: hasVisitAndQuote ?? this.hasVisitAndQuote,
        rejectOrderFailed: rejectOrderFailed ?? null,
        rejectOrderSuccess: rejectOrderSuccess ?? null);
  }
}
