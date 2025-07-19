import 'dart:convert';
import 'package:dio/dio.dart';
import '../env.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseApi {
  static BaseOptions _options() {
    return BaseOptions(
      baseUrl: "$baseUrl",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
      contentType: Headers.jsonContentType,
    );
  }

  Dio dioClient() {
    Dio dio = Dio(_options());
    dio.interceptors.add(PrettyDioLogger());
// customization
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  }

  String vendor_android_version = "1";
}
