import 'package:dio/dio.dart';
import 'package:zoo_market/common/services/global_network_constant.dart';
import 'package:zoo_market/common/services/network/unauthorized_api_service.dart';
import 'package:zoo_market/di/di_locator.dart';
import 'package:zoo_market/feature/sign_in/data/repository/global_personal_secure_data_repository.dart';

/// interceptor для отправки авторизационного хэдера
/// и обработки ошибок [401] и [403]
class BearerTokenInterceptor extends InterceptorsWrapper {
  BearerTokenInterceptor(this.dio)
      : _secureDataRepository = sl(),
        _authRepository = sl();

  final Dio dio;
  final GlobalPersonalSecureDataRepository _secureDataRepository;
  final UnauthorizedApiService _authRepository;

  /// максимальное количесво повтори при авторизационных ошибках
  static const maxRepeatCount = 3;

  /// счетчик для повторов запроса в случае авторизационных ошибок [401] и [403]
  int _repeatCounter = 0;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureDataRepository.accessToken;
    options.headers[GlobalNetworkConstant.authorization] =
        '${GlobalNetworkConstant.bearer} $accessToken';
    options.headers[GlobalNetworkConstant.serverApiKey] =
        '8SG6Bgr1.dWNhdJXUX4QmaNpZ9aMsT8sYXLtGzCqX';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _resetRepeatCounter();
    return handler.next(response);
  }

  /*@override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      // TODO need check this functions
      //dio.interceptors.
      dio.interceptors.requestLock.lock();
      dio.interceptors.responseLock.lock();

      final requestOptions = err.response?.requestOptions;

      try {
        final authResponse = await _authRepository.refreshToken();
        final accessToken = authResponse.access;
        _secureDataRepository.setAccessToken(
          accessToken ?? GlobalConstant.emptyString,
        );
        requestOptions?.headers[GlobalNetworkConstant.authorization] = '${GlobalNetworkConstant.bearer} $accessToken';

        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();

        /// обновляем счетчик если количество повторов превисило лимит
        if (_repeatCounter >= maxRepeatCount) {
          _resetRepeatCounter();
          return handler.reject(err);
        }

        _repeatCounter++;

        // TODO need check for null safety
        final response = await dio.fetch<dynamic>(requestOptions!);
        return handler.resolve(response);
      } catch (ex) {
        dio.interceptors.requestLock.unlock();
        dio.interceptors.responseLock.unlock();

        _resetRepeatCounter();
        return handler.reject(err);
      }
    } else {
      _resetRepeatCounter();
      return handler.reject(err);
    }
  }*/

  /// обновляет счетчик _repeatCounter
  /// необходимо обновление в случае успешного ответа от сервера
  /// или при ошибках кроме 401 и 403
  void _resetRepeatCounter() {
    _repeatCounter = 0;
  }
}
