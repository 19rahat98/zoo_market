import 'dart:async';
import 'package:dio/dio.dart';
import 'package:zoo_market/common/services/global_network_constant.dart';

/// сервис для неавторизованной зоны
class UnauthorizedApiService {
  UnauthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// авторизация
  Future<Response> signIn(
    String email,
    String password,
  ) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/auth/login/',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  /// авторизация
  Future<Response> checkUserStatus(String token) async {
    final client = await _httpClient;
    client.options.headers[GlobalNetworkConstant.authorization] = token;
    return client.post<dynamic>(
      '/firebase/CheckUserStatus',
    );
  }

  /// обновление токена
  Future<Response> refreshToken(String refreshToken) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/auth/token/refresh/',
      data: {
        'refresh': refreshToken,
      },
    );
  }
}
