import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_doctors_technician/Service_professional/commons/pagination_model/pagination_model.dart';

import '../../models/load_more_notifications_model.dart';
import '../../repository/notifications_repository.dart';

part 'notifications_data_state.dart';

class NotificationsDataCubit extends Cubit<NotificationsDataState> {
  final NotificationsRepository notificationsRepository;
  NotificationsDataCubit(this.notificationsRepository)
      : super(const NotificationsDataState());

  Future<void> featchNotifications({
    bool loadMoreData = false,
    required String seenStatus,
  }) async {
    try {
      // Loading indicator when data is being fetched
      emit(state.copyWith(dataLoading: !loadMoreData));
      if (loadMoreData && state.notificationsDataNewResponseModel != null) {
        print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<00000000000000<<<<<<<<<<<<<<<<<<<");
        // Run the fetch connection API if it's not the last page.
        if (!state.notificationsDataNewResponseModel!.paginationTestModel
            .isLastPage) {
          // Increase the current page counter
          state.notificationsDataNewResponseModel!.paginationTestModel
              .currentPage += 1;
          final moreData = await notificationsRepository.featchNotifications(
              page: state.notificationsDataNewResponseModel!.paginationTestModel
                  .currentPage,
              seenStatus: seenStatus);
          // Update the state with the new data.
          emit(
            state.copyWith(
              // Check if the items are already in the list to avoid duplicates.
              notificationsDataNewResponseModel: state
                  .notificationsDataNewResponseModel!
                  .paginationCopyWith(newData: moreData),
            ),
          );
          return;
        }
      } else {
        emit(state.copyWith(
          firstLoad: true,
        ));

        // emit(state.copyWith(
        //     notificationsDataNewResponseModel:
        //         NotificationsDataNewResponseModel(
        //             results: [],
        //             paginationTestModel:
        //                 PaginationTestModel(currentPage: 1, lastPage: 1))));
        print(">>>>>>>>>>>>>>>>>>>>1111111111111111>>>>>>>>>>>>>>>>>");
        // Refreshing or loading initial data
        // print(jsonEncode(state.notificationsDataNewResponseModel));

        final restoList1 = await notificationsRepository.featchNotifications(
          seenStatus: seenStatus,
        );
        print("res in cubit ::::: $restoList1");
        final restoList = restoList1[0];
        // print("<<<<<<<<<<<<<<<<${jsonEncode(restoList)}>>>>>>>>>>>>>");

        // Update the state with the new data.
        if (restoList1[1] == "invalid") {
          emit(state.copyWith(
              notificationsDataNewResponseModel:
                  NotificationsDataNewResponseModel(
                      results: [],
                      paginationTestModel:
                          PaginationTestModel(currentPage: 0, lastPage: 0)),
              firstLoad: false));
        } else {
          emit(state.copyWith(
              notificationsDataNewResponseModel: restoList, firstLoad: false));
        }
      }

      return;
    } catch (e) {
      // Error handling
      if (isClosed) {
        return;
      }
      if (state.moreNotificationsListNotAvailable) {
        emit(state.copyWith(error: e.toString(), dataLoading: false));
        return;
      } else {
        emit(state.copyWith(dataLoading: false));
        return;
      }
    }
  }

  Future<void> singleNotificationRead(String id, String status) async {
    try {
      emit(state.copyWith(singleTickLoad: true));
      final isRead =
          await notificationsRepository.singleViewNotifications(id: id);
      featchNotifications(seenStatus: status);
      emit(state.copyWith(isRead: isRead));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> markAsReadNotificationRead(String status) async {
    try {
      emit(state.copyWith(mardAsReadLoad: true));
      final isMarkAsRead =
          await notificationsRepository.markAsReasAllNotifications();
      featchNotifications(seenStatus: status);
      emit(state.copyWith(isMarkAsRead: isMarkAsRead));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
