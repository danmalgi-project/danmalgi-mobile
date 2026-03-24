import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:danmalgi_mobile/core/services/app_logger_service.dart';

final loggerProvider = Provider<Logger>((ref) {
  return Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );
});

// 2. 이를 래핑한 AppLoggerService 프로바이더
final appLoggerServiceProvider = Provider<AppLoggerService>((ref) {
  final logger = ref.watch(loggerProvider);
  return AppLoggerService(logger);
});
