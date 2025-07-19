part of 'orders_count_cubit.dart';

class OrdersCountState {
  final bool? isLoading;
  final OrdersCountModel? orderscount;
  OrdersCountState({this.orderscount, this.isLoading});

  OrdersCountState copyWith({
    OrdersCountModel? orderscount,
    bool? isLoading,
  }) {
    return OrdersCountState(
        orderscount: orderscount ?? this.orderscount,
        isLoading: isLoading ?? this.isLoading);
  }
}
