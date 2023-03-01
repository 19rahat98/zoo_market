import 'package:dio/dio.dart';

class AppDefaultHeaderInterceptor extends InterceptorsWrapper {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO add locale
    //final locale = await _localizationRepository.loadLocalization();
    //options.headers['Cookie'] = 'lang=$locale';
    super.onRequest(options, handler);
  }
}
