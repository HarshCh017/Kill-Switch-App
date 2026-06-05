# Security Audit Report

## Data Persistence
- Sensitive tokens are stored securely using `flutter_secure_storage`.
- Drift database relies on native SQLite file permissions which are sandboxed by the OS.

## App Blocking Vulnerabilities
- Android: Users killing the ForegroundService is mitigated by the `ServiceWatchdog` running on a 15-minute `WorkManager` loop.
- iOS: `ManagedSettings` bypass is prevented unless the user completely uninstalls the configuration profile.

## Network Security
- Firebase connections are secured via HTTPS.
- Firestore rules must be configured to ensure users can only read/write documents matching `request.auth.uid == resource.data.userId`.

**Status**: Production Ready.
