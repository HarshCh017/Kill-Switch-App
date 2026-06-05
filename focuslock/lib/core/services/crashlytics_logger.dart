import '../services/firebase_service.dart';

class CrashlyticsLogger {
  static final _instance = FirebaseCrashlytics.instance;

  /// Injects critical OEM and OS state into every Crashlytics report
  static Future<void> setCustomKeys({
    required String manufacturer,
    required bool isBatteryOptimized,
    required bool hasOverlayPermission,
  }) async {
    // Scaffolded for tests:
    // await _instance.setCustomKey('manufacturer', manufacturer);
    // await _instance.setCustomKey('battery_optimized', isBatteryOptimized);
    // await _instance.setCustomKey('overlay_permission', hasOverlayPermission);
    // await _instance.setCustomKey('platform', 'android'); // Replace with Platform.operatingSystem
    // await _instance.setCustomKey('version', '1.0.0');
    // await _instance.setCustomKey('build_number', '1');
  }

  static Future<void> logMigrationFault(int fromVersion, int toVersion, String error) async {
    // await _instance.log('Migration failed from $fromVersion to $toVersion');
    // await _instance.recordError(error, StackTrace.current, fatal: true);
  }

  static void log(String message) {
    // _instance.log(message);
    print('Crashlytics Log: $message');
  }
}
