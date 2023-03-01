import 'package:dio/dio.dart';

/// сервис для авторизованной зоны
class AuthorizedApiService {
  AuthorizedApiService(this._httpClient);

  final Future<Dio> _httpClient;

  /// получение информации о пользователе
  Future<Response> getUsersMe() async {
    final client = await _httpClient;
    return client.get<dynamic>('/auth/user_detail/');
  }

  /// делаем log out
  Future<Response> logOut(String token) async {
    final client = await _httpClient;
    return client.post<dynamic>(
      '/auth/logout/',
      data: {
        'refresh': token,
      },
    );
  }
}
