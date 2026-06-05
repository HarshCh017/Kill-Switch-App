import 'dart:io';
import 'package:flutter/foundation.dart';

/// Abstracts all `Platform.isX` checks out of the UI presentation layer (ISSUE-015)
class PlatformService {
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isWeb => kIsWeb;
}
