import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

void setupLogging() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = kReleaseMode ? Level.WARNING : Level.ALL;

  Logger.root.onRecord.listen(_printRecord);
}

void _printRecord(LogRecord r) {
  if (kReleaseMode) return;

  final time = r.time.toIso8601String().substring(11, 23);
  debugPrint('$time ${_icon(r.level)} [${r.loggerName}] ${r.message}');
  if (r.error != null) debugPrint('    ↳ ${r.error}');
  if (r.stackTrace != null && r.level >= Level.WARNING) {
    debugPrintStack(stackTrace: r.stackTrace);
  }
}

String _icon(Level level) {
  if (level >= Level.SEVERE) return '⛔';
  if (level >= Level.WARNING) return '⚠️';
  if (level >= Level.INFO) return '💡';
  return '🐛';
}
