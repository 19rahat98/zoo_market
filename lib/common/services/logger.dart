import 'dart:developer' as developer;

class UtilLogger {
  static const String TAG = 'ZooMarket';

  static log([String tag = TAG, dynamic msg]) {
    developer.log('$msg', name: tag);
  }

  ///Singleton factory
  static final UtilLogger _instance = UtilLogger._internal();

  factory UtilLogger() {
    return _instance;
  }

  UtilLogger._internal();
}
