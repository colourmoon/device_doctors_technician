import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../commons/pagination_model/pagination_model.dart';
import '../../model/all_order_type.dart';
import '../../model/all_orders_model.dart';
import '../../repository/all_orders_repository.dart';
import '../../screen/all_orders_screen.dart';

part 'all_orders_state.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  AllOrdersCubit()
      : super(const AllOrdersState(
          allOrderType: AllOrderType(title: "All", type: 'all'),
          isNewValueSelected: false,
        ));
  void changeDropdownValue(AllOrderType newValue) {
    emit(state.copyWith(allOrderType: newValue, isNewValueSelected: true));
  }

  void initStatefun(date) {
    emit(state.copyWith(
        dateRange: DateTimeRange(start: date, end: date), dateFetched: true));
  }
  void clean() {
    emit(state.copyWith(
      cleanRange: true,
      dateFetched: false,
      error: null,
      loadMoreOrderList: null,
      isNewValueSelected: false,
    ));
  }


  Future<void> fetchAllOrderList({
    bool loadMoreData = false,
    required String status,
    required String fromdate,
    required String todate,
  }) async {
    try {
      // DateTime from = DateTime.parse(fromdate);
      // DateTime to = DateTime.parse(todate);

      // Loading indicator when data is being fetched
      emit(state.copyWith(
          dataLoading: !loadMoreData,
          error: '',
          dateFetched: false,
          isNewValueSelected: false));
      if (loadMoreData && state.loadMoreOrderList != null) {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<00000000000000<<<<<<<<<<<<<<<<<<<");
        // Run the fetch connection API if it's not the last page.
        if (!state.loadMoreOrderList!.paginationTestModel.isLastPage) {
          // Increase the current page counter
          state.loadMoreOrderList!.paginationTestModel.currentPage += 1;
          final moreData = await AllOrdersListRepository().fetchAllOrderList(
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
                dataLoading: false),
          );
          return;
        }
      } else {
        print(">>>>>>>>>>>>>>>>>>>>1111111111111111>>>>>>>>>>>>>>>>>");
        // Refreshing or loading initial data
        // print(jsonEncode(state.loadMoreOrderList));

        final restoList = await AllOrdersListRepository().fetchAllOrderList(
            fromdate: fromdate, status: status, todate: todate);
        // print("<<<<<<<<<<<<<<<<${jsonEncode(restoList)}>>>>>>>>>>>>>");

        // Update the state with the new data.
        emit(state.copyWith(loadMoreOrderList: restoList, dataLoading: false));
      }

      return;
    } catch (e) {
      // Error handling
      if (isClosed) {
        return;
      }
      if (state.loadMoreRidesListNotAvailable) {
        log('jio_jai'.toString());
        log(e.toString(), name: "join");
        emit(state.copyWith(error: e.toString(), dataLoading: false));
        return;
      } else {
        log('jio_jai'.toString());
        log(e.toString(), name: "join");
        emit(state.copyWith(dataLoading: false, error: e.toString()));
        return;
      }
    }
  }

  // Future<void> fetchAllOrderList({
  //   bool loadMoreData = false,
  //   required String status,
  //   required String fromdate,
  //   required String todate,
  // }) async {
  //   print('Hellooooo*****11111111111111');
  //   print('LOADDDDDD >>>$loadMoreData');

  //   try {
  //     // Loading indicator when data is being fetched
  //     emit(state.copyWith(
  //         dataLoading: !loadMoreData || state.loadMoreOrderList == null));
  //     if (loadMoreData && state.loadMoreOrderList != null) {
  //       // Run the fetch connection API if it's not the last page.
  //       if (!state.loadMoreOrderList!.paginationTestModel.isLastPage) {
  //         // Increase the current page counter
  //         state.loadMoreOrderList!.paginationTestModel.currentPage += 1;
  //         final moreData = await AllOrdersListRepository().fetchAllOrderList(
  //             page: state.loadMoreOrderList!.paginationTestModel.currentPage,
  //             fromdate: fromdate,
  //             status: status,
  //             todate: todate);
  //         // Update the state with the new data.
  //         emit(
  //           state.copyWith(
  //             // Check if the items are already in the list to avoid duplicates.
  //             loadMoreOrderList: state.loadMoreOrderList!
  //                 .paginationCopyWith(newData: moreData),
  //           ),
  //         );
  //         return;
  //       }
  //     } else {
  //       // Refreshing or loading initial data
  //       final restoList = await AllOrdersListRepository().fetchAllOrderList(
  //           fromdate: fromdate, status: status, todate: todate);
  //       // Update the state with the new data.
  //       emit(state.copyWith(loadMoreOrderList: restoList));
  //     }

  //     return;
  //   } catch (e) {
  //     // Error handling
  //     if (isClosed) {
  //       return;
  //     }
  //     if (state.loadMoreRidesListNotAvailable) {
  //       emit(state.copyWith(error: e.toString(), dataLoading: false));
  //       return;
  //     } else {
  //       print('Error: $e');
  //       emit(state.copyWith(dataLoading: false));
  //       return;
  //     }
  //   }
  // }

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
