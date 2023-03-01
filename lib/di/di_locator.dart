// ignore_for_file: cascade_invocations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo_market/common/services/core_network.dart';
import 'package:zoo_market/common/services/network/authorized_api_service.dart';
import 'package:zoo_market/common/services/network/unauthorized_api_service.dart';
import 'package:zoo_market/feature/sign_in/data/global_personal_secure_data_source.dart';
import 'package:zoo_market/feature/sign_in/data/repository/global_personal_secure_data_repository.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  _commonModule();
  _apiServiceModule();
  await _dataSourceModule();
  _repositoryModule();
  _registerAuthorizedHttpClient();
  _registerServices();
}

/// для общих зависимостей
void _commonModule() {
  /// Shared preferences
  final sharedPreferences = SharedPreferences.getInstance();
  sl
    ..registerSingletonAsync(() => sharedPreferences)
    ..registerSingleton(const FlutterSecureStorage())
    ..registerSingletonAsync(() => createHttpClient('https://zoo-market.ddnsking.com/'));
}

void _apiServiceModule() {
  /// для неавторизованной зоны
  sl.registerSingleton(UnauthorizedApiService(sl.getAsync()));
}

/// для локального хранения данных
Future<void> _dataSourceModule() async {
  sl.registerSingleton(GlobalPersonalSecureDataSource());
}

/// для репозиторий
void _repositoryModule() {
  sl.registerFactory(GlobalPersonalSecureDataRepository.new);
}

void _registerServices() {}

void _registerAuthorizedHttpClient() {
  sl.registerSingletonAsync(
    () => createAuthorizedHttpClient('https://zoo-market.ddnsking.com/'),
    instanceName: 'authorized',
  );

  /// для авторизованной зоны
  sl.registerSingleton(
    AuthorizedApiService(
      sl.getAsync(
        instanceName: 'authorized',
      ),
    ),
  );
}
