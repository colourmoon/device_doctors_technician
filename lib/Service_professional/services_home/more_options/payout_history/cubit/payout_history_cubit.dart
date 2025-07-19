import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/models/payout_list_model.dart';
import 'package:device_doctors_technician/Service_professional/services_home/more_options/more_options_repository.dart';

import '../model/payouts_model.dart';

part 'payout_history_state.dart';

// class PayoutHistoryCubit extends Cubit<PayoutHistoryState> {
//   PayoutHistoryCubit() : super(const PayoutHistoryState());

//   Future<void> fetchPayoutList(fromDate, toDate, status) async {
//     try {
//       emit(state.copyWith(dataLoaded: true, payoutError: ''));

//       final payoutList = await MoreOptionsRepository()
//           .fetchPayoutList(fromDate, toDate, status);
//       emit(state.copyWith(payoutList: payoutList, dataLoaded: false));
//     } catch (e) {
//       print('ERROR FETCHING Issue $e');
//       emit(state.copyWith(payoutError: e.toString(), dataLoaded: false));
//     }
//   }
// }

class PayoutHistoryCubit extends Cubit<PayoutHistoryState> {
  PayoutHistoryCubit()
      : super(PayoutHistoryState(value: "Pending", isNewValueSelected: false));
  void changeDropdownValue(String newValue) {
    emit(state.copyWith(value: newValue, isNewValueSelected: true));
  }

  void initStatefun(date) {
    emit(state.copyWith(
        dateRange: DateTimeRange(start: date, end: date), dateFetched: true));
  }

  Future<void> fetchAllOrderList({
    bool loadMoreData = false,
    required String status,
    required String fromdate,
    required String todate,
  }) async {
    try {
      // Loading indicator when data is being fetched
      emit(state.copyWith(
          dataLoading: !loadMoreData,
          dateFetched: false,
          isNewValueSelected: false));
      if (loadMoreData && state.loadMoreOrderList != null) {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<00000000000000<<<<<<<<<<<<<<<<<<<");
        // Run the fetch connection API if it's not the last page.
        if (!state.loadMoreOrderList!.paginationTestModel.isLastPage) {
          // Increase the current page counter
          state.loadMoreOrderList!.paginationTestModel.currentPage += 1;
          final moreData = await MoreOptionsRepository().fetchPayoutList(
              page: state.loadMoreOrderList!.paginationTestModel.currentPage,
              fromdate: fromdate,
              status: status,
              todate: todate);
          // Update the state with the new data.
          emit(
            state.copyWith(
              // Check if the items are already in the list to avoid duplicates.
              loadMoreOrderList: state.loadMoreOrderList!
                  .paginationCopyWith(newData: moreData),
            ),
          );
          return;
        }
      } else {
        print(">>>>>>>>>>>>>>>>>>>>1111111111111111>>>>>>>>>>>>>>>>>");
        // Refreshing or loading initial data
        // print(jsonEncode(state.loadMoreOrderList));

        final restoList = await MoreOptionsRepository().fetchPayoutList(
            fromdate: fromdate, status: status, todate: todate);
        // print("<<<<<<<<<<<<<<<<${jsonEncode(restoList)}>>>>>>>>>>>>>");

        // Update the state with the new data.
        emit(state.copyWith(loadMoreOrderList: restoList));
      }

      return;
    } catch (e) {
      // Error handling
      if (isClosed) {
        return;
      }
      if (state.loadMoreRidesListNotAvailable) {
        emit(state.copyWith(error: e.toString(), dataLoading: false));
        return;
      } else {
        emit(state.copyWith(dataLoading: false));
        return;
      }
    }
  }

  dateRangePicker(context) async {
    await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023, 8, 4),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      saveText: 'Done',
    ).then((value) {
      emit(state.copyWith(dateRange: value, dateFetched: true));
    });
  }
}
