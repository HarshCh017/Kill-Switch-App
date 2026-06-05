# Setup Guide

## Requirements
- Flutter SDK (>=3.1.0)
- Android Studio / Android SDK
- Xcode (if compiling for iOS on Mac)

## Local Initialization
1. Run `flutter pub get`.
2. Generate Drift databases: `flutter pub run build_runner build --delete-conflicting-outputs`.
3. Configure Firebase: Place `google-services.json` in `android/app/` and `GoogleService-Info.plist` in `ios/Runner/`.
4. Run `flutter run`.
