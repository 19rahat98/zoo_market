import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:zoo_market/common/services/network/app_default_interceptor.dart';
import 'package:zoo_market/common/services/network/bearer_token_interceptor.dart';

Future<Dio> createHttpClient(
  String baseUrl, {
  bool userLogger = true,
}) async {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 50000;
  dio.options.receiveTimeout = 30000;

  dio.interceptors.add(
    AppDefaultHeaderInterceptor(),
  );


  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}

Future<Dio> createAuthorizedHttpClient(String baseUrl) async {
  final dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 50000;
  dio.options.receiveTimeout = 30000;

  dio.interceptors.add(AppDefaultHeaderInterceptor());
  dio.interceptors.add(BearerTokenInterceptor(dio));

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}
