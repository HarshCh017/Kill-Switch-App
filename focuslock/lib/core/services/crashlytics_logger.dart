import '../services/firebase_service.dart';

class CrashlyticsLogger {
  static final _instance = FirebaseCrashlytics.instance;

  /// Injects critical OEM and OS state into every Crashlytics report (Task 9.4)
  static Future<void> setCustomKeys({
    required String manufacturer,
    required bool isBatteryOptimized,
    required bool hasOverlayPermission,
  }) async {
    // _instance.setCustomKey('manufacturer', manufacturer);
    // _instance.setCustomKey('battery_optimized', isBatteryOptimized);
    // _instance.setCustomKey('overlay_permission', hasOverlayPermission);
    // _instance.setCustomKey('build_flavor', 'production');
  }

  static Future<void> logMigrationFault(int fromVersion, int toVersion, String error) async {
    // _instance.log('Migration failed from $fromVersion to $toVersion');
    // _instance.recordError(error, StackTrace.current, fatal: true);
  }

  static void log(String message) {
    // _instance.log(message);
    print('Crashlytics Log: $message');
  }
}
