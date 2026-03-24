import 'package:flutter/foundation.dart';

import 'package:logger/logger.dart';

class AppLoggerService {
  final Logger _logger;

  AppLoggerService(this._logger);

  void d(String message) {
    if (kDebugMode) {
      _logger.d(message);
    }
  }

  void i(String message) {
    _logger.i(message);
  }

  void w(String message) {
    _logger.w(message);
  }

  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
