import 'package:danmalgi_mobile/core/services/app_logger_service.dart';

mixin Loggable {
  AppLoggerService get logger;
  
  String get loggerName => runtimeType.toString();

  void logDebug(String message) {
    logger.d('[$loggerName] $message');
  }

  void logInfo(String message, {dynamic data}) {
    logger.i('[$loggerName] $message');
  }

  void logWarning(String message, {dynamic error}) {
    logger.w('[$loggerName] $message');
  }

  void logError(String message, {dynamic error, StackTrace? stackTrace}) {
    logger.e('[$loggerName] $message', error, stackTrace);
  }
}
