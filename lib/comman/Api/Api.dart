// import 'dart:async';
// import 'dart:io';
// import 'package:connectivity/connectivity.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// class API extends Cubit<ApiState> {
//   String url;
//   bool cancel;
//
//   API({required this.url, this.cancel = true}) : super(ApiLoadingState());
//
//   final Dio _dio = Dio();
//   StreamSubscription<Response>? _requestSubscription;
//
//   final bool _cancel = true;
//
//   void _cancelRequest() {
//     _requestSubscription?.cancel();
//     _requestSubscription = null;
//   }
//
//   Future<void> getRequest(
//     Map<String, String> queryParameters,
//     Function(dynamic) onApiSuccess,
//     Function(dynamic) onApiFailed,
//   ) async {
//     _cancelRequest();
//     final connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.none) {
//       // emit(ApiErrorState('No internet connection'));
//       return;
//     }
//     if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile) {
//       try {
//         final response = await _dio.get(
//           url,
//           queryParameters: queryParameters,
//         );
//         if (response.statusCode == 200) {
//           onApiSuccess(response.data);
//         } else {
//           onApiFailed(
//               "API request failed with status code: ${response.statusCode}");
//         }
//       } catch (error) {
//         onApiFailed("API request failed: $error");
//       }
//     }
//   }
//
//   void postApi(
//     Map<String, dynamic> queryParameters,
//     Function(Map<String, dynamic>) onApiSuccess,
//     Function(String) onApiFailed,
//   ) {
//     if (_cancel) {
//       _cancelRequest();
//     }
//     try {
//       _requestSubscription =
//           _dio.post(url, queryParameters: queryParameters).asStream().listen(
//         (response) async {
//           final connectivityResult = await Connectivity().checkConnectivity();
//           if (connectivityResult == ConnectivityResult.none) {
//             // emit(ApiErrorState('No internet connection'));
//             return onApiFailed(
//               Error(statusCode: 3, message: 'No internet connection')
//                   .toString(),
//             );
//           }
//           if (connectivityResult == ConnectivityResult.wifi ||
//               connectivityResult == ConnectivityResult.mobile) {
//             if (response.statusCode == 200) {
//               onApiSuccess(response.data);
//             }
//           }
//         },
//         onError: (error) {
//           if (error is SocketException) {
//             return onApiFailed(
//               Error(statusCode: 3, message: error.toString()).toString(),
//             );
//           } else {
//             return onApiFailed('Unable to connect to the Internet'.toString());
//           }
//         },
//         cancelOnError: true,
//       );
//     } catch (ex) {
//       onApiFailed(Error(statusCode: 3, message: ex.toString()).toString());
//     }
//   }
// }
//
// class Error {
//   int statusCode;
//   String? message;
//
//   Error({required this.statusCode, required this.message});
// }
