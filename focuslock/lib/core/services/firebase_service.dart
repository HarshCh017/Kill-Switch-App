import 'package:flutter/foundation.dart';

// Firebase mocks for scaffolding without pubspec errors
class Firebase {
  static Future<void> initializeApp() async {}
}

class FirebaseCrashlytics {
  static final instance = FirebaseCrashlytics();
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {}
  void recordError(dynamic exception, StackTrace? stack, {bool fatal = false}) {}
}

class FirebaseRemoteConfig {
  static final instance = FirebaseRemoteConfig();
  Future<void> setConfigSettings(dynamic settings) async {}
  Future<void> setDefaults(Map<String, dynamic> defaults) async {}
  Future<void> fetchAndActivate() async {}
}

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();

    if (!kIsWeb) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
    }

    await _initializeRemoteConfig();
  }

  static Future<void> _initializeRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setDefaults(const {
      'freeBlockLimit': 3,
      'minimumVersion': '1.0.0',
      'maintenanceMode': false,
      'emergencyStopBlocking': false,
    });
    await remoteConfig.fetchAndActivate();
  }
}
