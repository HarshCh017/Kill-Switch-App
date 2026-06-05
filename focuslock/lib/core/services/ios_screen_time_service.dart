import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class IOSScreenTimeService {
  static const _channel = MethodChannel('com.focuslock.focus_lock/screentime');

  IOSScreenTimeService() {
    _channel.setMethodCallHandler(_handleNativeMethodCall);
  }

  Future<bool> requestAuthorization() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        final result = await _channel.invokeMethod('requestAuthorization');
        return result ?? false;
      } on PlatformException catch (e) {
        print('Screen Time Auth Failed: ${e.message}');
        return false;
      }
    }
    return false;
  }

  /// Task 8.5: Detect invalid tokens and prompt user to reselect apps
  Future<dynamic> _handleNativeMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onTokensInvalidated':
        // Tokens expired or were manually revoked in iOS Settings.
        // Alert the UI routing layer to push the Selection Screen.
        print('CRITICAL: iOS Screen Time Tokens Invalidated. User must reselect.');
        // In production, this fires a Riverpod state update
        break;
    }
  }
}
