import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:device_doctors_technician/utility/auth_shared_pref.dart';

import '../../../../comman/Api/Base-Api.dart';
import '../../../../comman/Api/end_points.dart';
import '../../../commons/common_toast.dart';

enum NavigationEvent { home, Ongoing, Completed, Services, More }

class ServicesBottomBarCubit extends Cubit<int> {
  ServicesBottomBarCubit()
      : super(
          0,
        );

  void navigateToIndex(int index) {
    emit(index);
  }
}
