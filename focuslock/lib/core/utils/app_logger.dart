import 'package:flutter/foundation.dart';
import '../services/crashlytics_logger.dart';

enum LogLevel { debug, info, warning, error }

/// Centralized Logging Framework replacing raw print() statements (ISSUE-013)
class AppLogger {
  static void log(String message, {LogLevel level = LogLevel.info}) {
    final prefix = level.name.toUpperCase();
    final logMessage = '[$prefix] $message';

    if (kDebugMode) {
      print(logMessage);
    }

    if (level == LogLevel.error || level == LogLevel.warning) {
      CrashlyticsLogger.log(logMessage);
    }
  }

  static void debug(String message) => log(message, level: LogLevel.debug);
  static void info(String message) => log(message, level: LogLevel.info);
  static void warning(String message) => log(message, level: LogLevel.warning);
  static void error(String message) => log(message, level: LogLevel.error);
}
